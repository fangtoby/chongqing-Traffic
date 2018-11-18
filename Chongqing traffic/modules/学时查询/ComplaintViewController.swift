//
//  ComplaintViewController.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/17.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class ComplaintViewController: BaseViewController {

    lazy var complainView: ComplaintView = {
        let view = ComplaintView.init(frame: CGRect.zero)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "学时记录详情"
        
        setUpUI()
    }
    
    func setUpUI() {
        self.view.addSubview(complainView)
        self.complainView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationBarHeight)
            make.left.right.bottom.equalToSuperview()
        }
        self.complainView.complaintSelectObjectClick = { [weak self] in
            //选择投诉对象
            print("选择投诉对象")
            let selectObjectView = ComplaintSelectObjectView()
            selectObjectView.setData(data: ["教练", "驾校"])
            selectObjectView.complaintObjectClick = { (object) in
                self?.complainView.selectObjectLabel.text = object
                self?.complainView.selectObjectLabel.textColor = MainTextColor
                selectObjectView.hideView()
            }
        }
        
        self.complainView.complaintClick = { [weak self] in
            //一键投诉
            
        }
    }
}
