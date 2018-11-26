//
//  MineInfoView.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/18.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineInfoView: UIView {

    //用户图像
    lazy var userLogoImageView:UIImageView = {
        let iconImageView = UIImageView()
//        iconImageView.image = UIImage.init(named: "pic1.jpeg")
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 30
        iconImageView.contentMode = UIView.ContentMode.scaleAspectFill
        return iconImageView
    }()
    
    //用户姓名
    lazy var nameLabel:UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = KUIFont20
        nameLabel.textColor = MainYellowColor
//        nameLabel.text = "哈哈哈"
        return nameLabel
    }()
    
    //用户性别
    lazy var sexImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "icon_sex_man")
        return imageView
    }()
    
    //描述
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.font = KUIFont12
        descLabel.textColor = AssistColor
        descLabel.numberOfLines = 0
//        descLabel.text = "目前正在呱呱驾校学习C1技能"
        return descLabel
    }()
    
    //右边小箭头
    private var rightImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "icon_right_tip1")
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension MineInfoView {
    func setUpUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        //添加阴影
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.05
        //zero表示不偏移
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        
        self.addSubview(userLogoImageView)
        self.userLogoImageView.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 60, height: 60))
        }
        
        self.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(self.userLogoImageView.snp.right).offset(20)
            make.height.equalTo(28)
        }
        
        self.addSubview(sexImageView)
        self.sexImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel.snp.right).offset(10)
            make.bottom.equalTo(self.nameLabel.snp.bottom).offset(-5)
            make.right.lessThanOrEqualTo(-50)
        }
        
        self.addSubview(descLabel)
        self.descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel.snp.left)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(10)
            make.right.equalTo(-50)
        }
        
        self.addSubview(rightImageView)
        self.rightImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-30)
        }
    }
}
