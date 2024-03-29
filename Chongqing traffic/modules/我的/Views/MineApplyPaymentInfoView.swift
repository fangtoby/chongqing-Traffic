//
//  MineApplyPaymentInfoView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/20.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineApplyPaymentInfoView: UIView {

    //姓名
    private lazy var nameTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "姓名"
        return tipLabel
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
//        label.text = "李某某"
        return label
    }()
    
    //证件号码
    private lazy var codeTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "证件号码"
        return tipLabel
    }()
    lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
//        label.text = "350 103 **** **** 1399"
        return label
    }()
    
    //培训车型
    private lazy var trainTypeTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "培训车型"
        return tipLabel
    }()
    lazy var trainTypeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
//        label.text = "C1"
        return label
    }()
    
    //联系方式
    private lazy var phoneNumberTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "联系方式"
        return tipLabel
    }()
    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
//        label.text = "135 **** 1399"
        return label
    }()
    
    //赔付卡号
    private lazy var cardCodeTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "赔付卡号"
        return tipLabel
    }()
    lazy var cardCodeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
//        label.text = "招商银行  尾号1236"
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

extension MineApplyPaymentInfoView {
    func setUpUI() {
        self.addSubview(nameTipLabel)
        self.nameTipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(22)
            make.left.equalTo(40)
        }
        
        self.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameTipLabel.snp.right).offset(36)
            make.centerY.equalTo(self.nameTipLabel.snp.centerY)
        }
        
        self.addSubview(codeTipLabel)
        self.codeTipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameTipLabel.snp.bottom).offset(10)
            make.left.equalTo(self.nameTipLabel.snp.left)
        }
        
        self.addSubview(codeLabel)
        self.codeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel.snp.left)
            make.centerY.equalTo(self.codeTipLabel.snp.centerY)
        }
        
        self.addSubview(trainTypeTipLabel)
        self.trainTypeTipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.codeTipLabel.snp.bottom).offset(10)
            make.left.equalTo(self.nameTipLabel.snp.left)
        }
        
        self.addSubview(trainTypeLabel)
        self.trainTypeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel.snp.left)
            make.centerY.equalTo(self.trainTypeTipLabel.snp.centerY)
        }
        
        self.addSubview(phoneNumberTipLabel)
        self.phoneNumberTipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.trainTypeTipLabel.snp.bottom).offset(10)
            make.left.equalTo(self.nameTipLabel.snp.left)
        }
        
        self.addSubview(phoneNumberLabel)
        self.phoneNumberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel.snp.left)
            make.centerY.equalTo(self.phoneNumberTipLabel.snp.centerY)
        }
        
        self.addSubview(cardCodeTipLabel)
        self.cardCodeTipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.phoneNumberTipLabel.snp.bottom).offset(10)
            make.left.equalTo(self.nameTipLabel.snp.left)
        }
        
        self.addSubview(cardCodeLabel)
        self.cardCodeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel.snp.left)
            make.centerY.equalTo(self.cardCodeTipLabel.snp.centerY)
            make.bottom.equalToSuperview()
        }
    }
}
