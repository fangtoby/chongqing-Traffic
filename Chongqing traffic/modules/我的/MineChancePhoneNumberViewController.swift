//
//  MineChancePhoneNumberViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/15.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineChancePhoneNumberViewController: BaseViewController {

    var oldNumber:String? = nil
    
    private var isNewPhoneNumber:Bool = false
    
    
    lazy var chancePhoneView: MineChancePhoneNumberView = {
        let chancePhoneView = MineChancePhoneNumberView.init(frame: self.view.bounds)
        if oldNumber != nil, oldNumber != "" {
            chancePhoneView.oldNumberTextLabel.text = oldNumber
        }
        return chancePhoneView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改手机号"
        // Do any additional setup after loading the view.
        self.view.addSubview(chancePhoneView)
        self.chancePhoneView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(navigationBarHeight)
        }
        
        self.chancePhoneView.nextAndSureBtnClick = {[weak self]() in
            if self?.isNewPhoneNumber == false {
                self?.isNewPhoneNumber = true
                self?.chancePhoneView.oldNumberTitleLabel.text = "新手机号"
                self?.chancePhoneView.oldNumberTextLabel.isHidden = true
                self?.chancePhoneView.newPhoneNumberBgView.isHidden = false
                self?.chancePhoneView.imageCodeTextFeild.text = nil
                self?.chancePhoneView.codeTextFeild.text = nil
                self?.chancePhoneView.sureButton.setTitle("确认修改", for: .normal)
            }else {
                //修改手机号
                
            }
        }
    }
}
