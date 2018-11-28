//
//  PayManager.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/28.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

enum PayStateCode {
    case PayStateCodeSuccess  // 支付成功
    case PayStateCodeFailure  // 支付失败
    case PayStateCodeCancel   //取消支付
}

typealias PayCompleteCallBack = ((PayStateCode, String) -> (Void))

class PayManager: NSObject {

    var callback : PayCompleteCallBack?
    
    var appSchemeDict:NSMutableDictionary = NSMutableDictionary.init()
    
    static let instance = PayManager()
    
    /// 注册到APP
    func registerApplication() {
        let path = Bundle.main.path(forResource: "Info", ofType: "plist")
        let dict = NSDictionary.init(contentsOfFile: path!)
        let urlTypes = dict?["CFBundleURLTypes"] as? [NSDictionary]
        for urlTypeDict in urlTypes! {
            let urlName = urlTypeDict["CFBundleURLName"] as! String
            let urlSchemes = urlTypeDict["CFBundleURLSchemes"] as! [String]
            let urlScheme = urlSchemes.last
            if urlName == "weixin" {
                self.appSchemeDict.setValue(urlScheme, forKey: "weixin")
//                [WXApi registerApp:urlScheme]
            }else if urlName == "alipay" {
                // 保存支付宝scheme，以便发起支付使用
                self.appSchemeDict.setValue(urlScheme, forKey: "alipay")
            }
        }
    }
    
    /**
     支付回调URL
     
     @param url 回调URL
     */
    func handleOpenURL(url:URL) -> Bool {
        if url.host == "pay" {
//            return [WXApi handleOpenURL:url delegate:self]
        }else if url.host == "safepay" {
            // 支付跳转支付宝钱包进行支付，处理支付结果(在app被杀模式下，通过这个方法获取支付结果）
            AlipaySDK.defaultService()?.processOrder(withPaymentResult: url, standbyCallback: { (result) in
                let resultDic = result as NSDictionary?
                let resultStatus = resultDic?.object(forKey: "resultStatus") as! String
                let errStr = resultDic?.object(forKey: "memo") as? String
                var errorCode = PayStateCode.PayStateCodeSuccess
                switch Int(resultStatus) {
                    
                case 9000:// 成功
                errorCode = PayStateCode.PayStateCodeSuccess
                case 6001:// 取消
                errorCode = PayStateCode.PayStateCodeCancel
                default:
                errorCode = PayStateCode.PayStateCodeFailure
                }
                if PayManager.instance.callback != nil {
                    PayManager.instance.callback!(errorCode, errStr ?? "支付成功")
                }
                
            })
            AlipaySDK.defaultService()?.processAuth_V2Result(url, standbyCallback: { (result) in
                let resultDic = result as NSDictionary?
                print("result = \(String(describing: resultDic))")
                // 解析 auth code
                let resultStr = resultDic?.object(forKey: "result") as? String
                var authCode:String? = nil
                if (resultStr?.count)! > 0 {
                    let resultArr = resultStr?.components(separatedBy: "&")
                    for subResult in resultArr! {
                        if subResult.count > 10 && subResult.hasPrefix("auth_code=") {
                            authCode = (subResult as NSString).substring(from: 10)
                        }
                    }
                }
                print("授权结果 authCode = \(String(describing: authCode))")
            })
            return true
        }
        return false;
    }
    
    
    /**
     统一支付
     @param order 订单信息
     微信支付对象：NSDictionary(解析对应PayReq)
     支付宝支付：NSString
     @param callback 支付回调
     */
    func pay(order:Any?, callback:@escaping PayCompleteCallBack) {
        if order == nil {
            return
        }
        self.callback = callback
        
        if order is NSDictionary {
            //验证是否安装微信
//            if (![WXApi isWXAppInstalled]) {
//                if ([PayManager shareManager].callBack) {
//                    [PayManager shareManager].callBack(PayStateCodeFailure,@"您还没有安装微信！");
//                }
//                return;
//            }
//
//            // 微信
//            NSMutableDictionary *dict = order;//[payReq sendPayWithDic:payParams];
//            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//
//            //调起微信支付
//            PayReq* req             = [[PayReq alloc] init];
//            req.openID              = [dict objectForKey:@"appid"];
//            req.partnerId           = [dict objectForKey:@"partnerid"];
//            req.prepayId            = [dict objectForKey:@"prepayid"];
//            req.nonceStr            = [dict objectForKey:@"noncestr"];
//            req.timeStamp           = stamp.intValue;
//            req.package             = [dict objectForKey:@"package"];
//            req.sign                = [dict objectForKey:@"sign"];
//
//            [WXApi sendReq:req]
        }else if order is String {
            // 支付宝
            AlipaySDK.defaultService()?.payOrder(order as? String, fromScheme: self.appSchemeDict.object(forKey: "alipay") as? String, callback: { (result) in
                
                let resultDic = result as NSDictionary?
                let resultStatus = resultDic?.object(forKey: "resultStatus") as! String
                var errStr = resultDic?.object(forKey: "memo") as? String
                var errorCode = PayStateCode.PayStateCodeSuccess
                switch Int(resultStatus) {
                case 9000:// 成功
                    errorCode = PayStateCode.PayStateCodeSuccess;
                    errStr = "您已支付成功！"
                case 6001:// 取消
                    errorCode = PayStateCode.PayStateCodeCancel;
                    errStr = "您已取消支付！"
                default:
                    errorCode = PayStateCode.PayStateCodeFailure;
                    errStr = "支付失败！"
                }
                if PayManager.instance.callback != nil {
                    callback(errorCode,errStr!)
                }
            })
        }
        
    }
}
