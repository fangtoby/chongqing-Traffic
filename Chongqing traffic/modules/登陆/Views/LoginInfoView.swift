//
//  LoginInfoView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/6.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

// 创建闭包
typealias LoginBtnClick = () -> Void
typealias SelectDriving = () -> Void

class LoginInfoView: UIView, UITextFieldDelegate {
    
    var loginBtnClick : LoginBtnClick?
    var selectDriving : SelectDriving?
    
    
    lazy var loginTitleLabel : UILabel = {
        let loginTitleLabel = UILabel()
        loginTitleLabel.textColor = MainTitleColor
        loginTitleLabel.font = KUIFont18
        loginTitleLabel.text = "驾驶培训学时查询"
        return loginTitleLabel
    }()
    
    //手机号
    lazy var loginPhoneTextField:UITextField = {
       let loginPhoneTextFeild = UITextField()
        loginPhoneTextFeild.textColor = MainTextColor
        loginPhoneTextFeild.font = KUIFont16
        loginPhoneTextFeild.placeholder = "请输入手机号"
        loginPhoneTextFeild.backgroundColor = KUIColorBG
        loginPhoneTextFeild.layer.cornerRadius = 4;
        loginPhoneTextFeild.layer.shadowColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.21).cgColor
        loginPhoneTextFeild.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        loginPhoneTextFeild.layer.shadowOpacity = 1;
        loginPhoneTextFeild.layer.shadowRadius = 3;
        loginPhoneTextFeild.keyboardType = UIKeyboardType.numberPad
        loginPhoneTextFeild.leftViewMode = UITextField.ViewMode.always
        loginPhoneTextFeild.clearButtonMode = UITextField.ViewMode.whileEditing
        return loginPhoneTextFeild
    }()
    
    lazy var loginPhoneLeftView:UIView = {
       let loginPhoneLeftView = UIView()
        
        return loginPhoneLeftView;
    }()
    
    lazy var loginPhoneImage:UIImageView = {
       let loginPhoneImage = UIImageView()
        loginPhoneImage.image = UIImage(named: "icon_login_phone")
        return loginPhoneImage
    }()
    
    //身份证号
    lazy var loginNumberTextField:UITextField = {
        let loginNumberTextField = UITextField()
        loginNumberTextField.textColor = MainTextColor
        loginNumberTextField.font = KUIFont16
        loginNumberTextField.placeholder = "请输入身份证号"
        loginNumberTextField.backgroundColor = KUIColorBG
        loginNumberTextField.layer.cornerRadius = 4;
        loginNumberTextField.layer.shadowColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.21).cgColor
        loginNumberTextField.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        loginNumberTextField.layer.shadowOpacity = 1;
        loginNumberTextField.layer.shadowRadius = 3;
        loginNumberTextField.keyboardType = UIKeyboardType.numberPad
        loginNumberTextField.leftViewMode = UITextField.ViewMode.always
        loginNumberTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        return loginNumberTextField
    }()
    
    lazy var loginNumberLeftView:UIView = {
        let loginNumberLeftView = UIView()
        
        return loginNumberLeftView;
    }()
    
    lazy var loginNumberImage:UIImageView = {
        let loginNumberImage = UIImageView()
        loginNumberImage.image = UIImage(named: "icon_login_number")
        return loginNumberImage
    }()
    
    //培训车型
    lazy var loginDrivingTypeView: UIView = {
        let loginDrivingTypeView = UIView()
        loginDrivingTypeView.backgroundColor = KUIColorBG
        loginDrivingTypeView.layer.cornerRadius = 4
        loginDrivingTypeView.isUserInteractionEnabled = true
        loginDrivingTypeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchSelectDriving)))
        return loginDrivingTypeView
    }()
    
    lazy var loginDrivingTypeLeftView: UIView = {
        let loginDrivingTypeLeftView = UIView()
        
        return loginDrivingTypeLeftView
    }()
    
    lazy var loginDrivingTypeImage: UIImageView = {
        let loginDrivingTypeImage = UIImageView()
        loginDrivingTypeImage.image = UIImage(named: "icon_login_drivingType")
        return loginDrivingTypeImage
    }()
    
    lazy var loginDrivingTypeLabel: UILabel = {
        let loginDrivingTypeLabel = UILabel()
        loginDrivingTypeLabel.textColor = AssistColor
        loginDrivingTypeLabel.font = KUIFont16
        loginDrivingTypeLabel.text = "请选择培训车型"
        return loginDrivingTypeLabel
    }()
    
    //验证码
    lazy var loginCodeTextField:UITextField = {
        let loginCodeTextField = UITextField()
        loginCodeTextField.textColor = MainTextColor
        loginCodeTextField.font = KUIFont16
        loginCodeTextField.placeholder = "请输入验证码"
        loginCodeTextField.backgroundColor = KUIColorBG
        loginCodeTextField.layer.cornerRadius = 4;
        loginCodeTextField.layer.shadowColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.21).cgColor
        loginCodeTextField.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        loginCodeTextField.layer.shadowOpacity = 1;
        loginCodeTextField.layer.shadowRadius = 3;
        loginCodeTextField.keyboardType = UIKeyboardType.numberPad
        loginCodeTextField.leftViewMode = UITextField.ViewMode.always
        loginCodeTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        return loginCodeTextField
    }()
    
    lazy var loginCodeLeftView:UIView = {
        let loginCodeLeftView = UIView()
        
        return loginCodeLeftView;
    }()
    
    lazy var loginCodeImage:UIImageView = {
        let loginCodeImage = UIImageView()
        loginCodeImage.image = UIImage(named: "icon_login_code")
        return loginCodeImage
    }()
    
    lazy var loginCodeImageView:UIImageView = {
       let loginCodeImageView = UIImageView()
        loginCodeImageView.backgroundColor = KUIColorBG
        return loginCodeImageView
    }()

    //立即登录按钮
    lazy var loginButton : BaseButton = {
        let loginButton = BaseButton()
        loginButton.setTitle("登录", for: UIControl.State.normal)
        loginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginButton.titleLabel?.font = KUIFont16
        loginButton.backgroundColor = AssistTextColor
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 4.0
        loginButton.addTarget(self, action: #selector(loginClicked), for: UIControl.Event.touchUpInside)
        
        return loginButton
    }()
    
    lazy var loginTipLabel: UILabel = {
        let loginTipLabel = UILabel()
        loginTipLabel.textColor = UIColor.init(red: 250/255.0, green: 190/255.0, blue: 0/255.0, alpha: 1)
        loginTipLabel.font = KUIFont12
        loginTipLabel.numberOfLines = 0
        loginTipLabel.text = "为保障您的权益，请确保信息与驾校备案信息保持一致"
        loginTipLabel.textAlignment = NSTextAlignment.center
        return loginTipLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(loginTitleLabel)
        self.loginTitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(50)
            make.height.equalTo(25)
        }
        
        self.loginPhoneLeftView.addSubview(loginPhoneImage)
        self.loginPhoneImage.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.loginPhoneLeftView.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        self.loginPhoneTextField.leftView = self.loginPhoneLeftView
        
        self.addSubview(loginPhoneTextField)
        self.loginPhoneTextField.snp.makeConstraints { (make) in
            make.left.height.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.loginTitleLabel.snp.bottom).offset(30)
        }
        
        self.loginNumberLeftView.addSubview(loginNumberImage)
        self.loginNumberImage.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.loginNumberLeftView.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        self.loginNumberTextField.leftView = self.loginNumberLeftView
        
        self.addSubview(loginNumberTextField)
        self.loginNumberTextField.snp.makeConstraints { (make) in
            make.left.height.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.loginPhoneTextField.snp.bottom).offset(20)
        }
        
        self.loginDrivingTypeLeftView.addSubview(loginDrivingTypeImage)
        self.loginDrivingTypeImage.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.loginDrivingTypeView.addSubview(loginDrivingTypeLeftView)
        self.loginDrivingTypeLeftView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(40)
        }
        
        self.loginDrivingTypeView.addSubview(loginDrivingTypeLabel)
        self.loginDrivingTypeLabel.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(40)
        }
        
        self.addSubview(loginDrivingTypeView)
        self.loginDrivingTypeView.snp.makeConstraints { (make) in
            make.left.height.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.loginNumberTextField.snp.bottom).offset(20)
        }
        
        self.addSubview(loginCodeImageView)
        self.loginCodeImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 80, height: 40))
            make.right.equalTo(-40)
            make.top.equalTo(self.loginDrivingTypeView.snp.bottom).offset(20)
        }
        
        self.loginCodeLeftView.addSubview(loginCodeImage)
        self.loginCodeImage.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.loginCodeLeftView.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        self.loginCodeTextField.leftView = self.loginCodeLeftView
        
        self.addSubview(loginCodeTextField)
        self.loginCodeTextField.snp.makeConstraints { (make) in
            make.left.height.equalTo(40)
            make.right.equalTo(self.loginCodeImageView.snp.left).offset(-5)
            make.top.equalTo(self.loginCodeImageView.snp.top)
        }
        
        self.addSubview(loginButton)
        self.loginButton.snp.makeConstraints { (make) in
            make.left.height.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.loginCodeTextField.snp.bottom).offset(30)
        }
        
        self.addSubview(loginTipLabel)
        self.loginTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.loginButton.snp.bottom).offset(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func loginClicked(){
        guard let loginBtnClick = loginBtnClick else { return }
        loginBtnClick()
    }
    
    
    @objc func touchSelectDriving(){
//        print("选择车型")
        guard let selectDriving = selectDriving else {
            return
        }
        selectDriving()
    }
    
}

