//
//  ConstantIntro.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/5.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit

import SnapKit
import MJRefresh

let KScreenWidth = UIScreen.main.bounds.size.width
let KScreenHeigth = UIScreen.main.bounds.size.height
let DominantColor = UIColor.init(red: 239/255.0, green: 80/255.0, blue: 88/255.0, alpha: 1)
let FooterViewColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)

//字体大小
let KUIFont20 = UIFont.systemFont(ofSize: 20)
let KBUIFont20 = UIFont.boldSystemFont(ofSize: 20)
let KUIFont18 = UIFont.systemFont(ofSize: 18)
let KBUIFont18 = UIFont.boldSystemFont(ofSize: 18)
let KUIFont16 = UIFont.systemFont(ofSize: 16)
let KUIFont15 = UIFont.systemFont(ofSize: 15)
let KUIFont14 = UIFont.systemFont(ofSize: 14)
let KUIFont13 = UIFont.systemFont(ofSize: 13)
let KUIFont12 = UIFont.systemFont(ofSize: 12)
let KUIFont11 = UIFont.systemFont(ofSize: 11)
let KUIFont10 = UIFont.systemFont(ofSize: 10)


//字体颜色
let MainTitleColor = UIColor.init(red: 65/255.0, green: 58/255.0, blue: 57/255.0, alpha: 1)
let MainTextColor = UIColor.init(red: 74/255.0, green: 74/255.0, blue: 74/255.0, alpha: 1)
let AssistColor = UIColor.init(red: 178/255.0, green: 178/255.0, blue: 178/255.0, alpha: 1)
let MainYellowColor = UIColor.init(red: 250/255/0, green: 190/255.0, blue: 0/255.0, alpha: 1)
let MainRedColor = UIColor.init(red: 255/255.0, green: 148/255.0, blue: 148/255.0, alpha: 1)
//视图背景颜色
let KUIColorBG = UIColor.init(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1)
let KUIColorLine = UIColor.init(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)

// iphone X
var isIphone_X = UIApplication.shared.statusBarFrame.size.height == 44 ? true : false

// navigationBarHeight
let navigationBarHeight : CGFloat = isIphone_X ? 88 : 64
// tabBarHeight
let tabBarHeight : CGFloat = isIphone_X ? 49 + 34 : 49

let isLogin = "isLogin"

//func isIphone() -> Bool {
//    let inset:CGFloat = 0.0
//    if #available(iOS 11.0, *) {
//        if (UIApplication.shared.delegate?.window??.safeAreaInsets.bottom)! > inset {
//            return true
//        }else {
//            return false
//        }
//    } else {
//        return false
//    }
//}
