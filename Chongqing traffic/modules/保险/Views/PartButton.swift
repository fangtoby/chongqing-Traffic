//
//  PartButton.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/21.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class PartButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI() {
        self.titleLabel?.font = KUIFont12
        self.setTitleColor(MainTextColor, for: .normal)
        self.setTitleColor(MainYellowColor, for: .selected)
        self.setBackgroundImage(imageFromColor(color: KUIColorLine), for: .normal)
        self.setBackgroundImage(imageFromColor(color: UIColor(r: 255, g: 251, b: 237)), for: .selected)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4
    }
    
    //color转image
    func imageFromColor(color: UIColor) -> UIImage{
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        
        return image!
    }
}
