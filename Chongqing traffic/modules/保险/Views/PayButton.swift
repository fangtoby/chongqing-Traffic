//
//  PayButton.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/21.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class PayButton: UIButton {
    
    lazy var bgview: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "btn_pay_select_no")
        return imageView
    }()
    
    lazy var payTypeImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension PayButton {
    func setUpUI() {
        self.addSubview(bgview)
        self.bgview.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        self.bgview.addSubview(selectImageView)
        self.selectImageView.snp.makeConstraints { (make) in
            make.left.centerY.equalToSuperview()
        }
        
        self.bgview.addSubview(payTypeImageView)
        self.payTypeImageView.snp.makeConstraints { (make) in
            make.right.centerY.equalToSuperview()
            make.left.equalTo(self.selectImageView.snp.right).offset(10)
        }
    }
}
