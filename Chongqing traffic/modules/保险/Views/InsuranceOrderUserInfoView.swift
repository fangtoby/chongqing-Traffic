//
//  InsuranceOrderUserInfoView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/21.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class InsuranceOrderUserInfoView: UIView {
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.text = "类型"
        label.textColor = Main155Color
        return label
    }()
    
    lazy var oneBtn: PartButton = {
        let button = PartButton()
        button.tag = 101
        button.isSelected = true
        button.setTitle("科目一", for: .normal)
        button.layer.borderColor = MainYellowColor.cgColor
        button.addTarget(self, action: #selector(partButtonClicked(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var twoBtn: PartButton = {
        let button = PartButton()
        button.tag = 102
        button.setTitle("科目二", for: .normal)
        button.addTarget(self, action: #selector(partButtonClicked(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var threeBtn: PartButton = {
        let button = PartButton()
        button.tag = 103
        button.setTitle("科目三", for: .normal)
        button.addTarget(self, action: #selector(partButtonClicked(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var fourBtn: PartButton = {
        let button = PartButton()
        button.tag = 104
        button.setTitle("科目四", for: .normal)
        button.addTarget(self, action: #selector(partButtonClicked(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var fiveBtn: PartButton = {
        let button = PartButton()
        button.tag = 105
        button.setTitle("全科目套餐", for: .normal)
        button.addTarget(self, action: #selector(partButtonClicked(button:)), for: .touchUpInside)
        return button
    }()

    //填写赔付卡信息
    lazy var compensateLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.text = "请填写赔付卡信息"
        label.textColor = Main155Color
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
    
    @objc func partButtonClicked(button:UIButton) {
        switch button.tag {
        case 101:
            self.oneBtn.isSelected = true
            self.twoBtn.isSelected = false
            self.threeBtn.isSelected = false
            self.fourBtn.isSelected = false
            self.fiveBtn.isSelected = false
            
            self.oneBtn.layer.borderColor = MainYellowColor.cgColor
            self.twoBtn.layer.borderColor = KUIColorLine.cgColor
            self.threeBtn.layer.borderColor = KUIColorLine.cgColor
            self.fourBtn.layer.borderColor = KUIColorLine.cgColor
            self.fiveBtn.layer.borderColor = KUIColorLine.cgColor
        case 102:
            self.oneBtn.isSelected = false
            self.twoBtn.isSelected = true
            self.threeBtn.isSelected = false
            self.fourBtn.isSelected = false
            self.fiveBtn.isSelected = false
            
            self.oneBtn.layer.borderColor = KUIColorLine.cgColor
            self.twoBtn.layer.borderColor = MainYellowColor.cgColor
            self.threeBtn.layer.borderColor = KUIColorLine.cgColor
            self.fourBtn.layer.borderColor = KUIColorLine.cgColor
            self.fiveBtn.layer.borderColor = KUIColorLine.cgColor
        case 103:
            self.oneBtn.isSelected = false
            self.twoBtn.isSelected = false
            self.threeBtn.isSelected = true
            self.fourBtn.isSelected = false
            self.fiveBtn.isSelected = false
            
            self.oneBtn.layer.borderColor = KUIColorLine.cgColor
            self.twoBtn.layer.borderColor = KUIColorLine.cgColor
            self.threeBtn.layer.borderColor = MainYellowColor.cgColor
            self.fourBtn.layer.borderColor = KUIColorLine.cgColor
            self.fiveBtn.layer.borderColor = KUIColorLine.cgColor
        case 104:
            self.oneBtn.isSelected = false
            self.twoBtn.isSelected = false
            self.threeBtn.isSelected = false
            self.fourBtn.isSelected = true
            self.fiveBtn.isSelected = false
            
            self.oneBtn.layer.borderColor = KUIColorLine.cgColor
            self.twoBtn.layer.borderColor = KUIColorLine.cgColor
            self.threeBtn.layer.borderColor = KUIColorLine.cgColor
            self.fourBtn.layer.borderColor = MainYellowColor.cgColor
            self.fiveBtn.layer.borderColor = KUIColorLine.cgColor
        case 105:
            self.oneBtn.isSelected = false
            self.twoBtn.isSelected = false
            self.threeBtn.isSelected = false
            self.fourBtn.isSelected = false
            self.fiveBtn.isSelected = true
            
            self.oneBtn.layer.borderColor = KUIColorLine.cgColor
            self.twoBtn.layer.borderColor = KUIColorLine.cgColor
            self.threeBtn.layer.borderColor = KUIColorLine.cgColor
            self.fourBtn.layer.borderColor = KUIColorLine.cgColor
            self.fiveBtn.layer.borderColor = MainYellowColor.cgColor
        default: break
            
        }
    }
}

extension InsuranceOrderUserInfoView {
    func setUpUI() {
        self.addSubview(typeLabel)
        self.typeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(10)
        }
        
        self.addSubview(oneBtn)
        self.oneBtn.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.typeLabel.snp.bottom).offset(10)
            make.width.equalTo(56)
            make.height.equalTo(24)
        }
        
        self.addSubview(twoBtn)
        self.twoBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.oneBtn.snp.right).offset(10)
            make.top.equalTo(self.oneBtn.snp.top)
            make.width.equalTo(56)
            make.height.equalTo(24)
        }
        
        self.addSubview(threeBtn)
        self.threeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.twoBtn.snp.right).offset(10)
            make.top.equalTo(self.oneBtn.snp.top)
            make.width.equalTo(56)
            make.height.equalTo(24)
        }
        
        self.addSubview(fourBtn)
        self.fourBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.threeBtn.snp.right).offset(10)
            make.top.equalTo(self.oneBtn.snp.top)
            make.width.equalTo(56)
            make.height.equalTo(24)
        }
        
        self.addSubview(fiveBtn)
        self.fiveBtn.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(24)
            //56是科目一到科目四的宽，10是每个的间隔，140:(80+40+20):80是全科目的宽，40是左边距离，20是右边距离
            let allWidth:CGFloat = (56+10)*4 + 140
            if allWidth >= KScreenWidth {
                make.left.equalTo(self.fourBtn.snp.right).offset(10)
                make.top.equalTo(self.oneBtn.snp.top)
            }else {
                make.left.equalTo(40)
                make.top.equalTo(self.oneBtn.snp.bottom).offset(10)
            }
        }
        
        self.addSubview(compensateLabel)
        self.compensateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.fiveBtn.snp.bottom).offset(10)
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
