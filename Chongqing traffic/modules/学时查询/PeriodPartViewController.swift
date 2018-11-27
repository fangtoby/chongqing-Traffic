//
//  PeriodPartViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/16.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit
import MBProgressHUD

class PeriodPartViewController: BaseViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: self.view.bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    var part : Int = 0
    var dicInfo : NSDictionary?
    
    var periodSearchView : PeriodSearchView = {
        let searchView = PeriodSearchView.init(frame: CGRect.zero)
        
        return searchView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        loadData()
    }
    
    func loadData() {
        var params = [String : Any]()
        params["subject"] = part+1
        MBProgressHUD.showWait("请稍后...")
        NetWorkRequest(.periodStatus(params: params), completion: { [weak self](result) -> (Void) in
            let code = result.object(forKey: "code") as! Int
            if code == 0{
                self?.dicInfo = result.object(forKey: "data") as? NSDictionary
                self?.periodSearchView.setChartData(dicInfo: self?.dicInfo)
            }else if code == 402 {
                UserDefaults.standard.removeObject(forKey: isLogin)
                UserDefaults.standard.removeObject(forKey: loginInfo)
                let loginVC = LoginViewController()
                loginVC.reLoginDelegate = self
                loginVC.isFirstLogin = false
                self?.present(loginVC, animated: true, completion: nil)
            }
        })
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
//                print("查看学时记录")
                let periodRecordVC = PeriodRecordViewController()
                periodRecordVC.isHistory = self?.dicInfo?.object(forKey: "history") as? Bool ?? false
                periodRecordVC.part = self?.part ?? 0
                periodRecordVC.allStudy = self?.dicInfo?.object(forKey: "requireTime") as? Int ?? 0
                periodRecordVC.valid = self?.dicInfo?.object(forKey: "validTime") as? Int ?? 0
                self?.navigationController?.pushViewController(periodRecordVC, animated: true)
            case 14:
                //刷新并推送
                print("刷新并推送")
                self?.pushData()
                let insuranceVC = InsuranceViewController()
                insuranceVC.part = self?.part ?? 0
                self?.navigationController?.pushViewController(insuranceVC, animated: true)
            case 103:
                //投保说明
//                print("投保说明")
                let insuranceVC = InsuranceViewController()
                insuranceVC.part = self?.part ?? 0
                self?.navigationController?.pushViewController(insuranceVC, animated: true)
            default:
                print("Error: not found")
            }
        }
    }
    
    func pushData() {
        var params = [String : Any]()
        params["subject"] = part+1
        MBProgressHUD.showWait("推送中，请稍后...")
        NetWorkRequest(.push(params: params), completion: { [weak self](result) -> (Void) in
            let code = result.object(forKey: "code") as! Int
            if code == 0{
                //提示推送成功
                MBProgressHUD.showSuccess("推送成功")
            }else if code == 402 {
                UserDefaults.standard.removeObject(forKey: isLogin)
                UserDefaults.standard.removeObject(forKey: loginInfo)
                let loginVC = LoginViewController()
                loginVC.reLoginDelegate = self
                loginVC.isFirstLogin = false
                self?.present(loginVC, animated: true, completion: nil)
            }
        })
    }
    
    override func reLogin() {
        loadData()
    }
    
    ///当没有数据时  重新请求数据
    func reFreshData() {
        if self.dicInfo == nil {
            loadData()
        }
    }
}

