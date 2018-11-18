//
//  MineTrainInfoViewController.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/18.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineTrainInfoViewController: BaseViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeigth))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        
        return contentView
    }()
    
    lazy var mineInfoView: MineInfoView = {
        let view = MineInfoView()
        return view
    }()
    
    lazy var mineTrainInfoView: MineTrainInfoView = {
        let view = MineTrainInfoView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的培训信息"
        setUpUI()
    }
    
    func setUpUI() {
        self.view.addSubview(scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.scrollView.addSubview(contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.bottom.equalTo(self.scrollView)
        }
        
        self.contentView.addSubview(mineInfoView)
        self.mineInfoView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(4)
            make.height.equalTo(95)
        }
        
        mineInfoView.isUserInteractionEnabled = true
        mineInfoView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(mineInfoViewClick)))
        
        self.contentView.addSubview(mineTrainInfoView)
        self.mineTrainInfoView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.mineInfoView.snp.bottom)
            make.bottom.equalTo(mineTrainInfoView.currentLabel.snp.bottom).offset(30)
        }
    }
    
    @objc func mineInfoViewClick() {
        let mineInfoVC = MineInfoViewController()
        self.navigationController?.pushViewController(mineInfoVC, animated: true)
    }
}
