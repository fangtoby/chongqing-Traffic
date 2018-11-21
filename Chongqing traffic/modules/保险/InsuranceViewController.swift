//
//  InsuranceViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/21.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class InsuranceViewController: BaseViewController {
    
    lazy var sureBtn: BaseButton = {
        let button = BaseButton()
        button.titleLabel?.font = KUIFont16
        button.setTitle("确认无误", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MainTitleColor
        button.addTarget(self, action: #selector(sureButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var userInfoView: InsuranceUserInfoView = {
        let view = InsuranceUserInfoView()
        return view
    }()
    
    lazy var insuranceInfoView: InsuranceInfoView = {
        let view = InsuranceInfoView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "学车无忧险"
        
        setUpUI()
    }
    
    func setUpUI() {
        self.view.addSubview(sureBtn)
        self.sureBtn.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.bottom.equalTo(-(40 + safeAreaBottomHeight))
            make.height.equalTo(40)
        }
        
        self.view.addSubview(userInfoView)
        self.userInfoView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(navigationBarHeight)
        }
        
        self.view.addSubview(insuranceInfoView)
        self.insuranceInfoView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.userInfoView.snp.bottom)
            make.bottom.equalTo(self.sureBtn.snp.top).offset(-20)
        }
    }
    
    @objc func sureButtonClicked() {
        //确认信息
        let insuranceBuyView = InsuranceBuyView()
        self.view.addSubview(insuranceBuyView)
        insuranceBuyView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
        }
        
//        let insurancePayVC = InsurancePayViewController()
//        self.navigationController?.pushViewController(insurancePayVC, animated: true)
    }
}
