//
//  LoginHeaderView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/6.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class LoginHeaderView: UIView {

    lazy var logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pic1.jpeg")
        return imageView
    }()
    
    lazy var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = MainTitleColor
        titleLabel.font = KBUIFont20
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(logoImageView)
        self.logoImageView.layer.masksToBounds = true
        self.logoImageView.layer.cornerRadius = 40
        self.logoImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
            if isIphone_X {
                make.top.equalTo(60 + 44)
            }else {
                make.top.equalTo(60)
            }
        }
        
        self.addSubview(titleLabel)
        self.titleLabel.text = "山城交通"
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.logoImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(28)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
}
