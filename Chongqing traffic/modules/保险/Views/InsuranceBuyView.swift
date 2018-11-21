//
//  InsuranceBuyView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/21.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class InsuranceBuyView: UIView {
    
    lazy var orderInfoView: InsuranceOrderInfoView = {
        let view = InsuranceOrderInfoView()
        return view
    }()
    
    lazy var fillInfoView: InsuranceOrderUserInfoView = {
        let view = InsuranceOrderUserInfoView()
        return view
    }()
    
    lazy var sureBtn: BaseButton = {
        let button = BaseButton()
        button.titleLabel?.font = KUIFont16
        button.setTitle("确定", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MainTitleColor
        button.addTarget(self, action: #selector(sureButtonClicked), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func sureButtonClicked() {
        
    }
}

extension InsuranceBuyView {
    func setUpUI() {
        self.addSubview(orderInfoView)
        self.orderInfoView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        self.addSubview(fillInfoView)
        self.fillInfoView.snp.makeConstraints { (make) in
            make.top.equalTo(self.orderInfoView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        self.addSubview(sureBtn)
        self.sureBtn.snp.makeConstraints { (make) in
            make.left.height.equalTo(40)
            make.right.bottom.equalTo(-40)
            make.top.equalTo(self.fillInfoView.snp.bottom).offset(22)
        }
    }
}
