//
//  String+Extension.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/26.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

extension String {
    //手机号中间四位加密，并添加空格
    func phoneNumberEncryption(string:String) -> String {
        var phone = string
        phone = phone.replacingOccurrences(of: " ", with: "")
        
        if phone.count == 11 {
            let frontStr = phone.prefix(3)
            let lastStr = phone.suffix(3)
            phone = frontStr + " **** " + lastStr
        }else {
            return string
        }
        
        return phone
    }
    
    //手机号中间出生日期加密，并添加空格
    func cardnumbersEncryption(cardString:String) -> String {
        var cardStr = cardString
        cardStr = cardStr.replacingOccurrences(of: " ", with: "")
        if cardStr.count != 18 {
            return cardString
        }
        let firstStr = cardStr.prefix(3)
        
        let secondStr = (cardStr as NSString).substring(with: NSMakeRange(3, 3))
        
        let lastStr = cardStr.suffix(4)
        
        cardStr = firstStr + " " + secondStr + " **** **** " + lastStr
        
        return cardStr
    }
    
    ///校验手机号是否合法
    func isTelNumber()->Bool {
        let phoneRegex = "^(|(1[0,0-9][0,0-9]))\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with:self)
        
//        let mobile = "^1((3[0-9]|4[57]|5[0-35-9]|7[0678]|8[0-9])/d{8}$)"
//        let CM = "(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])//d{8}$)|(^1705//d{7}$)"
//        let CU = "(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])//d{8}$)|(^1709//d{7}$)"
//        let CT = "(^1(33|53|77|8[019])//d{8}$)|(^1700//d{7}$)"
//        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
//        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
//        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
//        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
//        if ((regextestmobile.evaluate(with: num) == true) || (regextestcm.evaluate(with: num) == true) || (regextestct.evaluate(with: num) == true) || (regextestcu.evaluate(with: num) == true))
//        {
//            return true
//
//        } else {
//            return false
//        }
    }
    
    //校验身份证号是否合法
    func checkIsIdentityCard() -> Bool {
    
        //判断是否为空
        if self.count <= 0 {
            return false
        }
        //判断是否是18位，末尾是否是x
        let regex2: String = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let identityCardPredicate = NSPredicate(format: "SELF MATCHES %@", regex2)
        if !identityCardPredicate.evaluate(with: self) {
            return false
        }
        //判断生日是否合法
        let range = NSRange(location: 6, length: 8)
        let datestr: String = (self as NSString).substring(with: range)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        if formatter.date(from: datestr) == nil {
            return false
        }
        //判断校验位
        if  self.count == 18 {
            let idCardWi: [String] = ["7", "9", "10", "5", "8", "4", "2", "1", "6", "3", "7", "9", "10", "5", "8", "4", "2"]
            //将前17位加权因子保存在数组里
            let idCardY: [String] = ["1", "0", "10", "9", "8", "7", "6", "5", "4", "3", "2"]
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            var idCardWiSum: Int = 0
            //用来保存前17位各自乖以加权因子后的总和
            for i in 0..<17 {
                idCardWiSum += Int((self as NSString).substring(with: NSRange(location: i, length: 1)))! * Int(idCardWi[i])!
            }
            let idCardMod: Int = idCardWiSum % 11
            //计算出校验码所在数组的位置
            let idCardLast: String = String(self.suffix(1))
            //得到最后一位身份证号码
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if idCardMod == 2 {
                if idCardLast == "X" || idCardLast == "x" {
                    return true
                } else {
                    return false
                }
            } else {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if (idCardLast as NSString).integerValue == Int(idCardY[idCardMod]) {
                    return true
                } else {
                    return false
                }
            }
        }
        return false
    }
}
