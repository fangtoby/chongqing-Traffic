//
//  InsurancePayViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/21.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class InsurancePayViewController: BaseViewController {
    
    lazy var orderUserInfoView: MineApplyPaymentInfoView = {
        let view = MineApplyPaymentInfoView()
        return view
    }()
    
    lazy var payView: InsurancePayInfoView = {
        let view = InsurancePayInfoView()
        return view
    }()
    
    lazy var payBtn: BaseButton = {
        let button = BaseButton()
        button.titleLabel?.font = KUIFont16
        button.setTitle("去支付", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MainTitleColor
        button.addTarget(self, action: #selector(goPayBtnClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "订单详情"
        
        setUpUI()
    }
    
    func setUpUI() {
        self.view.addSubview(orderUserInfoView)
        self.orderUserInfoView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(navigationBarHeight)
        }
        
        self.view.addSubview(payView)
        self.payView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.orderUserInfoView.snp.bottom)
        }
        
        self.view.addSubview(payBtn)
        self.payBtn.snp.makeConstraints { (make) in
            make.left.height.equalTo(40)
            make.right.equalTo(-40)
            make.bottom.equalTo(-(40 + safeAreaBottomHeight))
        }
    }
    
    @objc func goPayBtnClicked() {
        //去支付
        
    }
}
