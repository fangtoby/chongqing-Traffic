//
//  ZLAlertView.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/18.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class ZLAlertView: UIView {

    lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 2
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = MainTextColor
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var messegeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = UIColor(r: 51, g: 51, b: 51)
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        return label
    }()

    lazy var sureButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("确定", for: .normal)
        button.setTitleColor(UIColor(r: 16, g: 142, b: 233), for: .normal)
        button.setTitleColor(AssistTextColor, for: .highlighted)
        button.addTarget(self, action: #selector(sureBtnClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var cancleButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor(r: 16, g: 142, b: 233), for: .normal)
        button.setTitleColor(AssistTextColor, for: .highlighted)
        button.addTarget(self, action: #selector(cancleBtnClicked), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// 显示view
    func showView() {
        UIApplication.shared.keyWindow?.addSubview(self)
        backgroundColor = UIColor.clear
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = UIColor().hexStringToColor(hexString: "0x000000", alpha: 0.3)
            self.alertView.snp.updateConstraints { (make) in
                make.centerY.equalTo(KScreenHeigth/2.0)
            }
        }
    }
    
    /// 隐藏View
    func hideView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = UIColor.clear
            self.alertView.snp.updateConstraints { (make) in
                make.centerY.equalTo(KScreenHeigth+100)
            }
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
    
    @objc func sureBtnClicked() {
        hideView()
    }
    
    @objc func cancleBtnClicked() {
        hideView()
    }
}

extension ZLAlertView {
    func setUpUI() {
        self.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeigth)
        self.addSubview(alertView)
        self.alertView.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.centerY.equalTo(KScreenHeigth+100)
        }
        self.alertView.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(44)
        }
        
        self.alertView.addSubview(messegeLabel)
        self.messegeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.top.equalTo(self.titleLabel.snp.bottom)
        }
        
        self.alertView.addSubview(sureButton)
        self.sureButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(self.messegeLabel.snp.bottom)
            make.right.equalTo(self.alertView.snp.centerX)
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
        
        self.alertView.addSubview(cancleButton)
        self.cancleButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.sureButton.snp.right)
            make.right.equalToSuperview()
            make.top.equalTo(self.sureButton.snp.top)
            make.height.equalTo(50)
        }
    }
    
    //隐藏Title
    func isHidenTitle() {
        self.sureButton.snp.updateConstraints { (make) in
            make.top.equalTo(self.messegeLabel.snp.bottom).offset(17)
        }
    }
    
    //只显示确认按钮（隐藏取消按钮）
    func isHidenCancle() {
        self.cancleButton.isHidden = true
        self.sureButton.snp.updateConstraints { (make) in
            make.right.equalToSuperview()
        }
    }
}
