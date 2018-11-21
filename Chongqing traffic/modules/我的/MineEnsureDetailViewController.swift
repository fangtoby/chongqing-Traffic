//
//  MineEnsureDetailViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/20.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineEnsureDetailViewController: BaseViewController {

    lazy var ensureInfoView: MineEnsureOrderInfoView = {
        let view = MineEnsureOrderInfoView()
        return view
    }()
    
    lazy var applyPaymentBtn: BaseButton = {
        let button = BaseButton()
        button.titleLabel?.font = KUIFont16
        button.setTitle("申请理赔", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MainTitleColor
        button.addTarget(self, action: #selector(applyPaymentButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var detailInfoView: MineEnsureDetailView = {
        let view = MineEnsureDetailView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "保障详情"
        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    func setUpUI() {
        self.view.addSubview(ensureInfoView)
        self.ensureInfoView.snp.makeConstraints { (make) in
            make.top.equalTo(4 + navigationBarHeight)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        self.view.addSubview(applyPaymentBtn)
        self.applyPaymentBtn.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.bottom.equalTo(-(40 + safeAreaBottomHeight))
            make.height.equalTo(40)
        }
        
        self.view.addSubview(detailInfoView)
        self.detailInfoView.snp.makeConstraints { (make) in
            make.top.equalTo(self.ensureInfoView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.applyPaymentBtn.snp.top).offset(-20)
        }
    }
    
    @objc func applyPaymentButtonClicked() {
        //申请理赔
        let applyPaymentVC = MineApplyPaymentViewController()
        self.navigationController?.pushViewController(applyPaymentVC, animated: true)
    }
    
}
