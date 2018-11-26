//
//  BaseContentView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/5.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import Foundation

import ESTabBarController_swift

class BasicContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFit
        textColor = AssistColor
        highlightTextColor = MainYellowColor
        iconColor = AssistColor
        highlightIconColor = MainYellowColor
        backdropColor = UIColor.white
        highlightBackdropColor = UIColor.white
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
