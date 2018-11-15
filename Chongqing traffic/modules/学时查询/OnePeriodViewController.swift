//
//  OnePeriodViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/15.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class OnePeriodViewController: BaseViewController {
    
    var periodSearchView : PeriodSearchView = {
        let searchView = PeriodSearchView.init(frame: CGRect.zero)
        
        return searchView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(periodSearchView)
        self.periodSearchView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
//            make.bottom.equalTo(self.periodSearchView.freshAndPushButton.snp.bottom).offset(20)
        }
        // Do any additional setup after loading the view.
    }
}
