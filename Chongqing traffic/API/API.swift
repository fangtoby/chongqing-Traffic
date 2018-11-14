//
//  API.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/5.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import Foundation

import Moya

/**
 全局状态码说明
 状态码    状态类型    状态说明
 0      成功    表示请求成功执行
 -1     失败    表示请求执行失败
 401    错误    表示未认证，遇到返回此信息，应调用注册设备接口，获取token
 402    未登录
 403    错误    表示未授权，非法访问该接口，主要由于用户未登录（或者用户不能访问该接口，开发错误）
 406    错误    表示传输的参数非法
 417    错误    表示签名异常
 503    异常    服务器出现异常
 601    强制升级
 */
enum StatusCode:Int {
    case API_CODE_REQUEST_OK = 0
    case API_CODE_REQUEST_ERROR = -1
    case API_CODE_REGISTER_DEVICE_NO = 401
    case API_CODE_LOGIN_NO = 402
    case API_CODE_SERVER_ERROR = 503
    case API_CODE_FORCE_UPGRADE = 601 //强制升级
}

enum API {
    case deviceRegist(params:[String:Any])
    case newFeeds(type: Int, clumId: String) //最新帖子
}

extension API: TargetType {
    
    var baseURL: URL { return URL(string: "https://gears.ggxueche.com/")! }
    
    var path: String {
        switch self {
        case .deviceRegist: return "deviceRegist"
            case .newFeeds: return "bbs/newPosts"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    var task: Task {
        var parmeters = [String:Any]()
        
        switch self {
        case .deviceRegist(let params):
            parmeters = params
        case .newFeeds(let type, let clumId):
            parmeters["type"] = type
            parmeters["columnId"] = clumId
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    var headers: [String : String]? {
        var header: [String:String] = [:]
        var token = "0"
        
        if UserDefaults.standard.string(forKey: "token") != nil {
            token = UserDefaults.standard.string(forKey: "token")!
        }
        header["token"] = token
        
        let timestamp = String(Int((Date().timeIntervalSince1970)*1000))
        
        header["timestamp"] = timestamp
        
        var sig = token.appending(timestamp)
        sig = sig.appending("{driving}")
        let sign = sig.md5()
        
        header["sign"] = sign
        
        return header
    }
}
