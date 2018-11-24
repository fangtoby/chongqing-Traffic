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
    case deviceRegist(params:[String:Any])//设备注册
    case code(params:[String:Any])//获取验证码图片
    case login(params:[String:Any]) //登陆
    case studentInfo(params:[String:Any]) //学员信息
    case logout(params:[String:Any]) //退出
    case currentPart(params:[String:Any]) //当前培训部分接口
    case periodStatus(params:[String:Any]) //学员当前部分学时详情接口（包括保险文案）
    case periodList(params:[String:Any]) //获取教学日志列表
    case periodDetail(params:[String:Any]) //获取教学日志详情
    case periodHistoryList(params:[String:Any]) //获取归档的教学日志列表
    case periodHistoryDetail(params:[String:Any]) //获取归档的教学日志详情
    case push(params:[String:Any]) //推送接口
    case complaint(params:[String:Any]) //投诉接口
    case complaintStatus(params:[String:Any]) //是否可以投诉
}

extension API: TargetType {
    
    var baseURL: URL { return URL(string: "http://59.110.155.214:10088/")! }
    
    var path: String {
        switch self {
        case .deviceRegist: return "deviceRegist"
        case .code: return "image"
        case .login: return "login"
        case .studentInfo: return "student/stuDetail"
        case .logout: return "logout"
        case .currentPart: return "student/now"
        case .periodStatus: return "studentPeriod/periodStatus"
        case .periodList: return "studentPeriod/periodList"
        case .periodDetail: return "studentPeriod/periodDetail"
        case .periodHistoryList: return "studentPeriod/periodHistoryList"
        case .periodHistoryDetail: return "studentPeriod/periodHistoryDetail"
        case .push: return "push"
        case .complaint: return "complaint"
        case .complaintStatus: return "complaint/complaintStatusQuery"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .complaintStatus:
            return .get
        default:
            return .post
        }
        
    }
    var task: Task {
        var parameters = [String:Any]()
        
        switch self {
        case .deviceRegist(let params):
            parameters = params
        case .code(let params):
            parameters = params
        case .login(let params):
            parameters = params
        case .studentInfo(let params):
            parameters = params
        case .logout(let params):
            parameters = params
        case .currentPart(let params):
            parameters = params
        case .periodStatus(let params):
            parameters = params
        case .periodList(let params):
            parameters = params
        case .periodDetail(let params):
            parameters = params
        case .periodHistoryList(let params):
            parameters = params
        case .periodHistoryDetail(let params):
            parameters = params
        case .push(let params):
            parameters = params
        case .complaint(let params):
            parameters = params
        case .complaintStatus(let params):
            parameters = params
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
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
