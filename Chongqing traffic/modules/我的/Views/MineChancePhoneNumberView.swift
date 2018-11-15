//
//  MineChancePhoneNumberView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/15.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

// 创建闭包
typealias NextAndSureBtnClick = () -> Void

class MineChancePhoneNumberView: UIView {

    var nextAndSureBtnClick : NextAndSureBtnClick?
    
    ///原手机号
    lazy var oldNumberTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = KUIFont14
        titleLabel.textColor = UIColor.init(red: 155/255.0, green: 155/255.0, blue: 155/255.0, alpha: 1)
        titleLabel.text = "原手机号"
        return titleLabel
    }()
    
    lazy var oldNumberTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = KUIFont14
        textLabel.textColor = MainTextColor
        return textLabel
    }()
    
    ///新手机号
    lazy var newPhoneNumberBgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = AssistColor.cgColor
        return bgView
    }()
    
    lazy var newPhoneNuberTextFeild:UITextField = {
        let textFeild = UITextField()
        textFeild.font = KUIFont14
        textFeild.textColor = MainTextColor
        textFeild.placeholder = "请输入新的手机号"
        textFeild.clearButtonMode = UITextField.ViewMode.always
        return textFeild
    }()
    
    ///图片验证码
    private var imageCodeLabel: UILabel = {
        let imageCodeLabel = UILabel()
        imageCodeLabel.font = KUIFont14
        imageCodeLabel.textColor = UIColor.init(red: 155/255.0, green: 155/255.0, blue: 155/255.0, alpha: 1)
        imageCodeLabel.text = "图片验证码"
        return imageCodeLabel
    }()
    
    lazy var imageCodeTextBgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = AssistColor.cgColor
        return bgView
    }()
    
    lazy var imageCodeTextFeild: UITextField = {
        let textFeild = UITextField()
        textFeild.font = KUIFont14
        textFeild.textColor = MainTextColor
        textFeild.placeholder = "右侧字符"
        textFeild.clearButtonMode = UITextField.ViewMode.always
        return textFeild
    }()
    
    lazy var codeImage: UIImageView = {
        let codeImage = UIImageView()
        codeImage.backgroundColor = UIColor.init(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1)
        codeImage.layer.masksToBounds = true
        codeImage.layer.cornerRadius = 4
        return codeImage
    }()
    
    ///手机验证码
    private var codeLabel: UILabel = {
        let codeLabel = UILabel()
        codeLabel.font = KUIFont14
        codeLabel.textColor = UIColor.init(red: 155/255.0, green: 155/255.0, blue: 155/255.0, alpha: 1)
        codeLabel.text = "手机验证码"
        return codeLabel
    }()
    
    lazy var codeTextBgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = AssistColor.cgColor
        return bgView
    }()
    
    lazy var codeTextFeild: UITextField = {
        let textFeild = UITextField()
        textFeild.font = KUIFont14
        textFeild.textColor = MainTextColor
        textFeild.placeholder = "收到的验证码"
        textFeild.clearButtonMode = UITextField.ViewMode.always
        return textFeild
    }()
    
    lazy var codeButton: BaseButton = {
        let codeBtn = BaseButton()
        codeBtn.titleLabel?.font = KUIFont14
        codeBtn.setTitle("发送验证码", for: .normal)
        codeBtn.setTitleColor(.white, for: .normal)
        codeBtn.backgroundColor = MainTitleColor
        codeBtn.addTarget(self, action: #selector(sendCode), for: .touchUpInside)
        return codeBtn
    }()
    
    lazy var sureButton:BaseButton = {
       let button = BaseButton()
        button.titleLabel?.font = KUIFont16
        button.setTitle("下一步", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MainTitleColor
        button.addTarget(self, action: #selector(nextAndSure), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI() {
        self.addSubview(oldNumberTitleLabel)
        self.oldNumberTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(32)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }
        
        self.addSubview(oldNumberTextLabel)
        self.oldNumberTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.oldNumberTitleLabel.snp.top)
            make.left.equalTo(self.oldNumberTitleLabel.snp.right).offset(20)
        }
        
        self.addSubview(newPhoneNumberBgView)
        newPhoneNumberBgView.isHidden = true
        self.newPhoneNumberBgView.snp.makeConstraints { (make) in
            make.left.equalTo(self.oldNumberTitleLabel.snp.right).offset(20)
            make.right.equalTo(-40)
            make.height.equalTo(40)
            make.centerY.equalTo(self.oldNumberTitleLabel.snp.centerY)
        }
        
        self.newPhoneNumberBgView.addSubview(newPhoneNuberTextFeild)
        self.newPhoneNuberTextFeild.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(-15)
        }
        
        self.addSubview(imageCodeLabel)
        self.imageCodeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.oldNumberTextLabel.snp.bottom).offset(30)
            make.height.equalTo(20)
        }
        
        self.addSubview(codeImage)
        self.codeImage.snp.makeConstraints { (make) in
            make.right.equalTo(-40)
            make.centerY.equalTo(self.imageCodeLabel.snp.centerY)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        self.addSubview(imageCodeTextBgView)
        self.imageCodeTextBgView.snp.makeConstraints { (make) in
            make.left.equalTo(self.oldNumberTextLabel.snp.left)
            make.centerY.equalTo(self.imageCodeLabel.snp.centerY)
            make.height.equalTo(40)
            make.right.equalTo(self.codeImage.snp.left).offset(-8)
        }
        
        self.imageCodeTextBgView.addSubview(imageCodeTextFeild)
        self.imageCodeTextFeild.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(-15)
        }
        
        self.addSubview(codeLabel)
        self.codeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.imageCodeLabel.snp.bottom).offset(30)
            make.height.equalTo(20)
        }
        
        self.addSubview(codeButton)
        self.codeButton.snp.makeConstraints { (make) in
            make.right.equalTo(-40)
            make.centerY.equalTo(self.codeLabel.snp.centerY)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        self.addSubview(codeTextBgView)
        self.codeTextBgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.codeLabel.snp.centerY)
            make.height.equalTo(40)
            make.left.equalTo(self.oldNumberTextLabel.snp.left)
            make.right.equalTo(self.imageCodeTextBgView.snp.right)
        }
        
        self.codeTextBgView.addSubview(codeTextFeild)
        self.codeTextFeild.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(-15)
        }
        
        self.addSubview(sureButton)
        self.sureButton.snp.makeConstraints { (make) in
            make.left.height.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.codeLabel.snp.bottom).offset(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @objc func sendCode() {
        //发送验证码
        
    }
    
    @objc func nextAndSure() {
        guard let nextAndSureBtnClick = nextAndSureBtnClick else { return }
        nextAndSureBtnClick()
    }
    
}
