//
//  PeriodPartViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/16.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class PeriodPartViewController: BaseViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: self.view.bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    var part : Int = 0

    var periodSearchView : PeriodSearchView = {
        let searchView = PeriodSearchView.init(frame: CGRect.zero)
        
        return searchView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .cyan
        setUpUI()
    }
    
    func setUpUI() {
        self.view.addSubview(scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.scrollView.addSubview(periodSearchView)
        self.periodSearchView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.bottom.equalTo(self.scrollView)
        }
        if part == 0 {
            self.periodSearchView.studyLabel.snp.updateConstraints { (make) in
                make.width.equalTo(40)
            }
        }else if part == 1 {
            self.periodSearchView.studyLabel.snp.updateConstraints { (make) in
                make.width.equalTo(80)
            }
        }else if part == 2 {
//            self.periodSearchView.studyLabel.snp.updateConstraints { (make) in
//                make.width.equalTo(40)
//            }
        }else if part == 3 {
            self.periodSearchView.studyLabel.snp.updateConstraints { (make) in
                make.width.equalTo(160)
            }
        }
        self.periodSearchView.periodAllBtnClick = { [weak self](subject) in
            switch subject {
            case 11:
                //有效时长
                print("有效时长")
            case 12:
                //未推送考试系统
                let trainingStatusVC = TrainningStatusIViewController()
                self?.present(trainingStatusVC, animated: true, completion: nil)
            case 13:
                //查看学时记录
                print("查看学时记录")
                let periodRecordVC = PeriodRecordViewController()
                periodRecordVC.part = self?.part ?? 0
                self?.navigationController?.pushViewController(periodRecordVC, animated: true)
            case 14:
                //刷新并推送
                print("刷新并推送")
                
            default:
                print("Error: not found")
            }
        }
    }
}

