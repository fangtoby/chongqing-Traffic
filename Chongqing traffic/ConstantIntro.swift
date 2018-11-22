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

//字体大小
let KUIFont20 = UIFont.systemFont(ofSize: 20)
let KBUIFont20 = UIFont.boldSystemFont(ofSize: 20)
let KUIFont18 = UIFont.systemFont(ofSize: 18)
let KBUIFont18 = UIFont.boldSystemFont(ofSize: 18)
let KUIFont16 = UIFont.systemFont(ofSize: 16)
let KBUIFont16 = UIFont.boldSystemFont(ofSize: 16)
let KUIFont15 = UIFont.systemFont(ofSize: 15)
let KUIFont14 = UIFont.systemFont(ofSize: 14)
let KUIFont13 = UIFont.systemFont(ofSize: 13)
let KUIFont12 = UIFont.systemFont(ofSize: 12)
let KUIFont11 = UIFont.systemFont(ofSize: 11)
let KUIFont10 = UIFont.systemFont(ofSize: 10)


//字体颜色
let MainTitleColor = UIColor(r: 65, g: 58, b: 57)
let MainTextColor = UIColor(r: 74, g: 74, b: 74)
let AssistTextColor = UIColor(r: 125, g: 115, b: 113)
let AssistColor = UIColor(r: 178, g: 178, b: 178)
let MainYellowColor = UIColor(r: 250, g: 190, b: 0)
let MainRedColor = UIColor(r: 255, g: 148, b: 148)
let MainBlueColor = UIColor(r: 105, g: 171, b: 209)
let MainGreenColor = UIColor(r: 173, g: 215, b: 106)
let Main155Color = UIColor(r: 155, g: 155, b: 155)
//视图背景颜色
let KUIColorUnEnable = UIColor(r: 125, g: 115, b: 113)

let KUIColorBG = UIColor(r: 246, g: 246, b: 246)
let KUIColorLine = UIColor(r: 238, g: 238, b: 238)

// iphone X
var isIphone_X = UIApplication.shared.statusBarFrame.size.height == 44 ? true : false

// navigationBarHeight
let navigationBarHeight : CGFloat = isIphone_X ? 88 : 64
// tabBarHeight
let safeAreaBottomHeight : CGFloat = isIphone_X ? 34 : 0

let statusHeight : CGFloat = isIphone_X ? 44 : 20


let tabBarHeight : CGFloat = isIphone_X ? 49 + 34 : 49

///本地化存储字段
let isLogin = "isLogin" //是否登陆
let loginInfo = "loginInfo"//登录信息
let userInfo = "userInfo" //用户信息

