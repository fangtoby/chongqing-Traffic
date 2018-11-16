//
//  ZLPageStyle.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/16.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

enum ZLLabelLayout {
    case scroll   //滚动
    case divide   //平分
    case center   //居中
}

class ZLPageStyle {
    
    var labelHeight:CGFloat = 44            //标签高度
    var labelMargin:CGFloat = 0            //标签间隔
    var labelFont:CGFloat = 16              //标签字体大小
    var labelLayout:ZLLabelLayout = .divide   //默认可以滚动
    var selectColor:UIColor = UIColor(r: 255, g: 0, b: 0)  //字体颜色必须为rgb格式
    var normalColor:UIColor = UIColor(r: 0, g: 0, b: 0)    //字体颜色必须为rgb格式
    var isShowLabelScale:Bool = true        //是否显示文字动画
    
    //整体titleView的下划线
    var isShowBottomLine = true //是否显示
    var bottomLineColor:UIColor = UIColor(r: 238, g: 238, b: 238)
    
    
    //单个title的下滑线
    var isShowTitleBottomLine:Bool = true        //是否显示底部的线
    var titleBottomLineColor:UIColor = .red
    var isBottomAlginLabel:Bool = true        //bottomline跟随文字标签宽度  默认跟随label的宽度 false跟随labelText的宽度
    
    ///title缩放
    var isTitleScaleEnabled:Bool = false    //当前选择文字是否变大
    var titleMaximumScaleFactor: CGFloat = 1.2
    
}
