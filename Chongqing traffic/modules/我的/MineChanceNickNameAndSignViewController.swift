//
//  MineChanceNickNameAndSignViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/15.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineChanceNickNameAndSignViewController: BaseViewController {
    var changeType:Int = 1//1:修改昵称 2:修改签名
    
    var nickNameStr:String? = nil
    
    lazy var nickNameBgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 4
        bgView.layer.borderColor = KUIColorLine.cgColor
        bgView.layer.borderWidth = 1
        return bgView
    }()
    
    lazy var nickName: UITextField = {
        let nickName = UITextField()
        nickName.textColor = MainTextColor
        nickName.font = KUIFont14
        if changeType == 1 {
            nickName.placeholder = "请输入昵称"
        }else {
            nickName.placeholder = "请输入签名"
        }
        nickName.clearButtonMode = UITextField.ViewMode.always
        return nickName
    }()
    
    lazy var sureButton: BaseButton = {
        let sureBtn = BaseButton()
        sureBtn.setTitle("保存", for: UIControl.State.normal)
        sureBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        sureBtn.titleLabel?.font = KUIFont12
        sureBtn.backgroundColor = MainTitleColor
        sureBtn.layer.masksToBounds = true
        sureBtn.layer.cornerRadius = 4.0
        sureBtn.addTarget(self, action: #selector(buttonClicked), for: UIControl.Event.touchUpInside)
        return sureBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        if changeType == 1 {
            self.title = "修改昵称"
        }else {
            self.title = "修改签名"
        }
        
        // Do any additional setup after loading the view.
        
        if nickNameStr != nil {
            nickName.text = nickNameStr
        }
        
        self.view.addSubview(nickNameBgView)
        self.nickNameBgView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(navigationBarHeight + 22)
            make.height.equalTo(40)
        }
        
        self.nickNameBgView.addSubview(nickName)
        self.nickName.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(-15)
        }
        
        self.view.addSubview(sureButton)
        self.sureButton.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(self.nickName.snp.bottom).offset(20)
            make.size.equalTo(CGSize.init(width: 60, height: 24))
        }
    }
    
    @objc func buttonClicked(){
        //修改昵称
        
    }
}
