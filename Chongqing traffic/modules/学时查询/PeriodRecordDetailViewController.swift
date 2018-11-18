//
//  PeriodRecordDetailViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/16.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class PeriodRecordDetailViewController: BaseViewController {
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: self.view.bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    lazy var contentView: UIView = {
        let contentView = UIView()
        
        return contentView
    }()
    
    lazy var recordDetailInfoView: PeriodRecordDetailInfoView = {
        let view = PeriodRecordDetailInfoView.init(frame: CGRect.zero)
        
        return view
    }()
    
    lazy var recordDetailImagesView: PeriodRecordDetailImagesView = {
        let view = PeriodRecordDetailImagesView.init(frame: CGRect.zero)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "学时记录详情"
        // Do any additional setup after loading the view.
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
        
        self.contentView.addSubview(recordDetailInfoView)
        self.recordDetailInfoView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        self.contentView.addSubview(recordDetailImagesView)
        self.recordDetailImagesView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.recordDetailInfoView.snp.bottom)
//            make.bottom.equalTo(self.recordDetailImagesView.beginLabel.snp.bottom).offset(20)
        }
        
        self.recordDetailInfoView.complaintBtnClick = { [weak self] in
            //一键投诉
            let complainVC = ComplaintViewController()
            self?.navigationController?.pushViewController(complainVC, animated: true)
        }
    }
    
}
