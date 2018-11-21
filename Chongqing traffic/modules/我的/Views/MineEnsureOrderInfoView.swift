//
//  MineEnsureOrderInfoView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/20.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineEnsureOrderInfoView: UIView {
    
    //订单号
    lazy var orderNumberLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = MainTextColor
        label.text = "订单号：15789411"
        return label
    }()
    
    //订单状态
    lazy var orderStatusLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont12
        label.textColor = MainYellowColor
        label.text = "保障中"
        return label
    }()
    
    //保险图片
    lazy var ensureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = KUIColorBG
        return imageView
    }()
    
    //保险名称
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = KBUIFont16
        label.textColor = MainTitleColor
        label.text = "科目一无忧险"
        return label
    }()
    
    //被保人
    lazy var userLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.text = "被保险人  李某某"
        return label
    }()
    
    //有效期
    lazy var validDateLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.text = "有效期限  365天"
        return label
    }()
    
    //保险单号
    lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont12
        label.textColor = MainGreenColor
        label.text = "保险单号  158896458758"
        return label
    }()
    
    //保险期限
    lazy var termDateLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont12
        label.textColor = MainGreenColor
        label.text = "* 保险期限  2018年7月8日0时  至  2019年7月8日0时"
        label.numberOfLines = 0
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension MineEnsureOrderInfoView {
    func setUpUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        //添加阴影
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.05
        //zero表示不偏移
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        
        ///订单号
        self.addSubview(orderNumberLabel)
        self.orderNumberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(20)
        }
        
        ///订单状态
        self.addSubview(orderStatusLabel)
        self.orderStatusLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-30)
            make.centerY.equalTo(self.orderNumberLabel.snp.centerY)
        }
        
        ///保险图片
        self.addSubview(ensureImageView)
        self.ensureImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.orderNumberLabel.snp.left)
            make.top.equalTo(self.orderNumberLabel.snp.bottom).offset(10)
            if KScreenWidth >= 375 {
                make.width.equalTo(160)
                make.height.equalTo(90)
            }else {
                make.width.equalTo(100)
                make.height.equalTo(100*9/16)
            }
        }
        
        ///保险名称
        self.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.ensureImageView.snp.top)
            make.left.equalTo(self.ensureImageView.snp.right).offset(29)
            make.right.lessThanOrEqualTo(-15)
        }
        
        ///被保人
        self.addSubview(userLabel)
        self.userLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.ensureImageView.snp.centerY).offset(-2)
            make.left.equalTo(self.nameLabel.snp.left)
            make.right.lessThanOrEqualTo(-15)
        }
        
        ///有效期
        self.addSubview(validDateLabel)
        self.validDateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.ensureImageView.snp.bottom).offset(3)
            make.left.equalTo(self.nameLabel.snp.left)
            make.right.lessThanOrEqualTo(-15)
        }
        
        ///保单号
        self.addSubview(codeLabel)
        self.codeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.orderNumberLabel.snp.left)
            make.top.equalTo(self.ensureImageView.snp.bottom).offset(20)
            make.right.lessThanOrEqualTo(-15)
        }
        
        ///保险期限
        self.addSubview(termDateLabel)
        self.termDateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.orderNumberLabel.snp.left).offset(-9)
            make.top.equalTo(self.codeLabel.snp.bottom).offset(6)
            make.bottom.equalTo(-15)
        }
    }
}
