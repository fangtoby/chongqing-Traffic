//
//  InsuranceOrderUserInfoView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/21.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class InsuranceOrderUserInfoView: UIView {
    
    var selected:PartButton? = nil
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.text = "类型"
        label.textColor = Main155Color
        return label
    }()
    
    lazy var insuranceBgView: UIView = {
        let view = UIView()
        return view
    }()

    //填写赔付卡信息
    lazy var compensateLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.text = "请填写赔付卡信息"
        label.textColor = Main155Color
        return label
    }()
    
    ///银行卡提示(仅限本人银行卡号)
    private lazy var bankTipLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.text = "(仅限本人银行卡号)"
        label.textColor = MainRedColor
        return label
    }()
    
    //银行卡号
    lazy var codeBgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = KUIColorLine.cgColor
        return view
    }()
    lazy var codeTextField: UITextField = {
        let textFeild = UITextField()
        textFeild.placeholder = "请输入银行卡号"
        textFeild.font = KUIFont14
        textFeild.textColor = MainTextColor
        textFeild.clearButtonMode = UITextField.ViewMode.always
        textFeild.keyboardType = UIKeyboardType.numberPad
        return textFeild
    }()
    
    //开户行
    lazy var bankBgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = KUIColorLine.cgColor
        return view
    }()
    lazy var bankTextField: UITextField = {
        let textFeild = UITextField()
        textFeild.placeholder = "请输入开户行"
        textFeild.font = KUIFont14
        textFeild.textColor = MainTextColor
        textFeild.clearButtonMode = UITextField.ViewMode.always
        return textFeild
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension InsuranceOrderUserInfoView {
    func setUpUI() {
        self.addSubview(typeLabel)
        self.typeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(10)
        }
        
        self.addSubview(insuranceBgView)
        self.insuranceBgView.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.typeLabel.snp.bottom).offset(10)
            make.right.equalTo(-40)
        }
        
        self.addSubview(compensateLabel)
        self.compensateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.insuranceBgView.snp.bottom).offset(10)
        }
        
        self.addSubview(bankTipLabel)
        self.bankTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.compensateLabel.snp.right)
            make.centerY.equalTo(self.compensateLabel.snp.centerY)
        }
        
        self.addSubview(codeBgView)
        self.codeBgView.snp.makeConstraints { (make) in
            make.left.height.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.compensateLabel.snp.bottom).offset(10)
        }
        self.codeBgView.addSubview(codeTextField)
        self.codeTextField.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.bottom.right.equalToSuperview()
        }
        
        self.addSubview(bankBgView)
        self.bankBgView.snp.makeConstraints { (make) in
            make.left.height.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.codeBgView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
        self.bankBgView.addSubview(bankTextField)
        self.bankTextField.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.bottom.right.equalToSuperview()
        }
    }
}
