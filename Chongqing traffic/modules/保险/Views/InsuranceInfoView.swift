//
//  InsuranceInfoView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/21.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class InsuranceInfoView: UIView {

    //服务条款
    private lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.text = "服务条款"
        label.textColor = Main155Color
        return label
    }()
    
    lazy var webView: UIWebView = {
        let webView = UIWebView()
        webView.backgroundColor = KUIColorBG
        return webView
    }()
    
    lazy var agreeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage.init(named: "icon_select_no"), for: .normal)
        button.setBackgroundImage(UIImage.init(named: "icon_select_yes"), for: .selected)
        button.isSelected = true
        button.addTarget(self, action: #selector(agreeTermClicked(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var agreeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont12
        label.text = "我已阅读并同意以上条款"
        label.textColor = MainTitleColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        
        webView.loadRequest(URLRequest.init(url: URL(string: "http://59.110.155.214:10022/TermsOfService.html")!))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func agreeTermClicked(button:UIButton) {
        if button.isSelected == true {
            button.isSelected = false
        }else {
            button.isSelected = true
        }
    }
    
    func loadWebUrl(url:String) {
        
    }
}

extension InsuranceInfoView {
    func setUpUI() {
        
        self.addSubview(tipLabel)
        self.tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(40)
        }
        
        self.addSubview(agreeButton)
        self.agreeButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-20)
            make.left.equalTo(40)
            make.width.height.equalTo(14)
        }
        
        self.addSubview(agreeLabel)
        self.agreeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.agreeButton.snp.right).offset(8)
            make.centerY.equalTo(self.agreeButton.snp.centerY)
        }
        
        self.addSubview(webView)
        self.webView.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.tipLabel.snp.bottom).offset(7)
            make.bottom.equalTo(self.agreeLabel.snp.top).offset(-10)
        }
    }
}
