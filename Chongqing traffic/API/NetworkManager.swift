//
//  NetworkManager.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/12.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import HandyJSON
import SVProgressHUD

/// 超时时长
private var requestTimeOut:Double = 20
///成功数据的回调
typealias successCallback = ((NSDictionary) -> (Void))
///验证码接口成功专用****************
typealias successCodeCallback = ((Data) -> (Void))
///失败的回调
typealias failedCallback = ((NSDictionary) -> (Void))
///网络错误的回调
typealias errorCallback = (() -> (Void))

///网络请求的基本设置,这里可以拿到是具体的哪个网络请求，可以在这里做一些设置
private let myEndpointClosure = { (target: API) -> Endpoint in
    ///这里把endpoint重新构造一遍主要为了解决网络请求地址里面含有? 时无法解析的bug https://github.com/Moya/Moya/issues/1198
    let url = target.baseURL.absoluteString + target.path
    var task = target.task
    
    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: task,
        httpHeaderFields: target.headers
    )
    requestTimeOut = 20//每次请求都会调用endpointClosure 到这里设置超时时长 也可单独每个接口设置
    
    return endpoint
}

///网络请求的设置
private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        //设置请求时长
        request.timeoutInterval = requestTimeOut
        // 打印请求参数
        if let requestData = request.httpBody {
            print("url:\(request.url!)"+"\n"+"params:"+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        }else{
            print("\(request.url!)"+"\(String(describing: request.httpMethod))")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

/// NetworkActivityPlugin插件用来监听网络请求，界面上做相应的展示
///但这里我没怎么用这个。。。 loading的逻辑直接放在网络处理里面了
private let networkPlugin = NetworkActivityPlugin.init { (changeType, targetType) in
    
    //targetType 是当前请求的基本信息
    switch(changeType){
    case .began:
        print("开始请求网络")
//        SVProgressHUD.show()
    case .ended:
        print("结束")
//        SVProgressHUD.dismiss()
    }
}

// https://github.com/Moya/Moya/blob/master/docs/Providers.md  参数使用说明
//stubClosure   用来延时发送网络请求


////网络请求发送的核心初始化方法，创建网络请求对象
let Provider = MoyaProvider<API>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)



/// 最常用的网络请求，只需知道正确的结果无需其他操作时候用这个
///
/// - Parameters:
///   - target: 网络请求
///   - completion: 请求成功的回调
func NetWorkRequest(_ target: API, completion: @escaping successCallback ){
    NetWorkRequest(target, completion: completion, failed: nil, errorResult: nil)
}

///****************************************************************************************
///获取验证码图片接口专用
func NetWorkRequest (_ target: API, codeCompletion: @escaping successCodeCallback ) {
    NetWorkRequest(target, codeCompletion: codeCompletion, failed: nil, errorResult: nil)
}

func NetWorkRequest(_ target: API, codeCompletion: @escaping successCodeCallback , failed:failedCallback?, errorResult:errorCallback?) {
    //先判断网络是否有链接 没有的话直接返回--代码略
    if !isNetworkConnect{
        print("提示用户网络似乎出现了问题")
        SVProgressHUD.showProgress(3, status: "网络似乎出现了问题")
        SVProgressHUD.dismiss(withDelay: 2.0)
        return
    }
    
    //这里显示loading图
    Provider.request(target) { (result) in
        
        switch result {
            
        case let .success(response):
            print(response)
            
            let jsonString = String.init(data: response.data, encoding: .utf8)
            if jsonString == nil {
                codeCompletion(response.data)
                return
            }
            let dic = getDictionaryFromJSONString(jsonString: jsonString!)
            print(dic)
            
            switch dic["code"] as? Int {
            case StatusCode.API_CODE_REGISTER_DEVICE_NO.rawValue:
                print("注册设备")
                deviceRegistCode(target: target, completion: codeCompletion)
                
            case StatusCode.API_CODE_FORCE_UPGRADE.rawValue:
                print("强制升级")
            case StatusCode.API_CODE_SERVER_ERROR.rawValue:
                print("服务器忙,请稍后再试")
            case StatusCode.API_CODE_LOGIN_NO.rawValue:
                print("未登录")
                
            default:
                print("aaaaaa")
            }
        case let .failure(error):
            print("错误原因：\(error.errorDescription ?? "")")
        }
    }
}

func deviceRegistCode(target: API?, completion: @escaping successCodeCallback) {
    var registParams = [String:Any]()
    registParams["deviceType"] = "IOS"
    registParams["deviceToken"] = UIDevice.current.identifierForVendor?.uuidString
    registParams["clientVersion"] = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
    
    NetWorkRequest(.deviceRegist(params: registParams), completion: { (result) -> (Void) in
        let dataInfo:NSDictionary = result.object(forKey: "data") as! NSDictionary
        print(dataInfo)
        UserDefaults.standard.set(dataInfo["token"], forKey: "token")
        if target != nil {
            NetWorkRequest(target!, codeCompletion: completion)
        }
    })
}

///**************************************************************************************************************

/// 需要知道成功或者失败的网络请求， 要知道code码为其他情况时候用这个
///
/// - Parameters:
///   - target: 网络请求
///   - completion: 成功的回调
///   - failed: 请求失败的回调
func NetWorkRequest(_ target: API, completion: @escaping successCallback , failed:failedCallback?) {
    NetWorkRequest(target, completion: completion, failed: failed, errorResult: nil)
}

///  需要知道成功、失败、错误情况回调的网络请求   像结束下拉刷新各种情况都要判断
///
/// - Parameters:
///   - target: 网络请求
///   - completion: 成功
///   - failed: 失败
///   - error: 错误
func NetWorkRequest(_ target: API, completion: @escaping successCallback , failed:failedCallback?, errorResult:errorCallback?) {
    //先判断网络是否有链接 没有的话直接返回--代码略
    if !isNetworkConnect{
        print("提示用户网络似乎出现了问题")
        SVProgressHUD.showProgress(3, status: "网络似乎出现了问题")
        SVProgressHUD.dismiss(withDelay: 2.0)
        return
    }
    
    //这里显示loading图
    Provider.request(target) { (result) in
        //隐藏hud
        switch result {

        case let .success(response):
            print(response)
            
            let jsonString = String.init(data: response.data, encoding: .utf8)
            if jsonString == nil {
                return
            }
            let dic = getDictionaryFromJSONString(jsonString: jsonString!)
            print(dic)
            
            switch dic["code"] as? Int {
            case StatusCode.API_CODE_REQUEST_OK.rawValue:
                completion(dic)

            case StatusCode.API_CODE_LOGIN_NO.rawValue:
                print("去登陆")
                failed!(dic)
            case StatusCode.API_CODE_REGISTER_DEVICE_NO.rawValue:
                print("注册设备")
                deviceRegist(target: target, completion: completion)

            case StatusCode.API_CODE_FORCE_UPGRADE.rawValue:
                print("强制升级")
            case StatusCode.API_CODE_SERVER_ERROR.rawValue:
                print("服务器忙,请稍后再试")

            default:
                print("aaaaaa")
            }
        case let .failure(error):
            print("错误原因：\(error.errorDescription ?? "")")
        }
    }
}

func deviceRegist(target: API?, completion: @escaping successCallback) {
    var registParams = [String:Any]()
    registParams["deviceType"] = "IOS"
    registParams["deviceToken"] = UIDevice.current.identifierForVendor?.uuidString
    registParams["clientVersion"] = Bundle.main.infoDictionary!["CFBundleShortVersionString"]

    
    NetWorkRequest(.deviceRegist(params: registParams), completion: { (result) -> (Void) in
        let dataInfo:NSDictionary = result.object(forKey: "data") as! NSDictionary
        print(dataInfo)
        UserDefaults.standard.set(dataInfo["token"], forKey: "token")
        if target != nil {
            NetWorkRequest(target!, completion: completion)
        }
    })
}

/// 基于Alamofire,网络是否连接，，这个方法不建议放到这个类中,可以放在全局的工具类中判断网络链接情况
/// 用get方法是因为这样才会在获取isNetworkConnect时实时判断网络链接请求，如有更好的方法可以fork
var isNetworkConnect: Bool {
    get{
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? true //无返回就默认网络已连接
    }
}
