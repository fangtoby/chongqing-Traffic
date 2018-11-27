//
//  InsurancePayInfoView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/21.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class InsurancePayInfoView: UIView {
    private lazy var insuranceTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.text = "保障信息"
        tipLabel.textColor = Main155Color
        return tipLabel
    }()
    
    lazy var insuranceLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
//        label.text = "科目一  考试不通过赔付补考费用"
        label.textColor = MainYellowColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var orderMoneyTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.text = "订单金额"
        tipLabel.textColor = Main155Color
        return tipLabel
    }()
    
    lazy var orderMoneyLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
//        label.text = "￥30"
        label.textColor = MainYellowColor
        return label
    }()
    
    private lazy var payTypeTipLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.text = "请选择支付方式"
        label.textColor = Main155Color
        return label
    }()
    
    lazy var payTypeBgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.borderColor = KUIColorLine.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var aliPayBtn: UIButton = {
        let button = UIButton()
        button.tag = 11
        button.isSelected = true
        button.setImage(UIImage.init(named: "btn_payali_no"), for: .normal)
        button.setImage(UIImage.init(named: "btn_payali_yes"), for: .selected)
        button.addTarget(self, action: #selector(selectPayTypeClicked(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var wechatPayBtn: UIButton = {
        let button = UIButton()
        button.tag = 12
        button.isSelected = false
        button.setImage(UIImage.init(named: "btn_paywechat_no"), for: .normal)
        button.setImage(UIImage.init(named: "btn_paywechat_yes"), for: .selected)
        button.addTarget(self, action: #selector(selectPayTypeClicked(button:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension InsurancePayInfoView {
    func setUpUI() {
        self.addSubview(insuranceTipLabel)
        self.insuranceTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(20)
        }
        self.addSubview(insuranceLabel)
        self.insuranceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.insuranceTipLabel.snp.right).offset(8)
            make.top.equalTo(self.insuranceTipLabel.snp.top)
            make.right.lessThanOrEqualTo(-20)
        }
        
        self.addSubview(orderMoneyTipLabel)
        self.orderMoneyTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.insuranceLabel.snp.bottom).offset(10)
        }
        self.addSubview(orderMoneyLabel)
        self.orderMoneyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.insuranceLabel.snp.left)
            make.centerY.equalTo(self.orderMoneyTipLabel.snp.centerY)
        }
        
        self.addSubview(payTypeTipLabel)
        self.payTypeTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.orderMoneyLabel.snp.bottom).offset(20)
        }
        
        self.addSubview(payTypeBgView)
        self.payTypeBgView.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.payTypeTipLabel.snp.bottom).offset(7)
            make.height.equalTo(66)
            make.bottom.equalToSuperview()
        }
        
        self.payTypeBgView.addSubview(aliPayBtn)
        self.aliPayBtn.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(self.snp.centerX)
        }
        
        self.payTypeBgView.addSubview(wechatPayBtn)
        self.wechatPayBtn.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(self.aliPayBtn.snp.right)
        }
    }
    
    @objc func selectPayTypeClicked (button:UIButton) {
        if button.tag == 11 {
            if aliPayBtn.isSelected == true {
                return
            }
            aliPayBtn.isSelected = true
            wechatPayBtn.isSelected = false
        }else if button.tag == 12 {
            if wechatPayBtn.isSelected == true {
                return
            }
            wechatPayBtn.isSelected = true
            aliPayBtn.isSelected = false
        }
    }
}
