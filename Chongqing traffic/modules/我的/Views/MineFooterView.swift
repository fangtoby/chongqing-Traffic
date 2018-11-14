//
//  MineFooterView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/5.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineFooterView: UITableViewHeaderFooterView {

    lazy var lineView : UIView = {
        let view = UIView()
        
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        self.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalTo(0)
            make.height.equalTo(30)
        }
    }

}
