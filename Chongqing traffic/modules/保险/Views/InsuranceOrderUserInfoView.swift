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
        selected?.isSelected = false
        selected?.layer.borderColor = KUIColorLine.cgColor
        
        button.isSelected = true
        button.layer.borderColor = MainYellowColor.cgColor
        selected = button as? PartButton
    }
    
    func setInsuranceProduct(insurance:[String]) {
        var orginX:CGFloat = 0
        var orginY:CGFloat = 0
        let buttonHeight:CGFloat = 24
        let space:CGFloat = 10
        
        for i in 0..<insurance.count {
            let str = insurance[i]
            let button = PartButton()
            
            button.tag = 100 + i
            if i == 0 {
                button.isSelected = true
                button.layer.borderColor = MainYellowColor.cgColor
                selected = button
            }
            button.setTitle(str, for: .normal)
            button.addTarget(self, action: #selector(partButtonClicked(button:)), for: .touchUpInside)
            
            var btnWidth = sizeWithText(text: str as NSString, font: KUIFont12, size: CGSize.init(width: KScreenWidth - 80, height: buttonHeight))
            if btnWidth+20 > KScreenWidth - 80 {
                btnWidth = KScreenWidth - 100
            }
            if orginX + btnWidth + 20 > KScreenWidth - 80 {
                orginX = 0
                orginY = orginY + buttonHeight + space
            }
            
            insuranceBgView.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.left.equalTo(orginX)
                make.top.equalTo(orginY)
                make.width.equalTo(btnWidth + 20)
                make.height.equalTo(buttonHeight)
                if i == insurance.count - 1 {
                    make.bottom.equalToSuperview()
                }
            }
            
            orginX = orginX + btnWidth + 20 + space
        }
    }
    
    /**
     * 计算字符串长度
     */
    func sizeWithText(text: NSString, font: UIFont, size: CGSize) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size.width;
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
