//
//  PeriodRecordViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/16.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit
import MBProgressHUD
import MJRefresh

class PeriodRecordViewController: BaseViewController {
    var part : Int = 0 //当前部分
    var dataSource = [Any]()
    var isHistory = false  //是否已归档
    var page = 1  //分页参数
    var allStudy:Int = 0 //全部学时
    var valid:Int = 0 //有效学时
    
    lazy var periodRecordHeaderView: PeriodRecordHeaderView = {
        let headerView = PeriodRecordHeaderView.init(frame: CGRect.zero)
        headerView.backgroundColor = .white
        headerView.layer.cornerRadius = 10
        //添加阴影
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowOpacity = 0.05
        //zero表示不偏移
        headerView.layer.shadowOffset = CGSize.zero
        headerView.layer.shadowRadius = 5
        return headerView
    }()
    
    lazy var tableHeaderView: UIView = {
        let tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: 101))
        
        return tableHeaderView
    }()
    
    let CellIdentifier = "periodRecordTableViewCell"
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: navigationBarHeight, width: KScreenWidth, height: KScreenHeigth - navigationBarHeight))
        tableView.tableHeaderView = tableHeaderView
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
        tableView.MJ_Header = DIYFreshHeader { [weak self] in self?.reFreshData() }
        tableView.MJ_Footer = DIYRefreshFooter { [weak self] in self?.loadMoreData() }
        tableView.register(PeriodRecordTableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if part == 0 {
            self.title = "第一部分学时记录"
        }else if part == 1 {
            self.title = "第二部分学时记录"
        }else if part == 2 {
            self.title = "第三部分学时记录"
        }else if part == 3 {
            self.title = "第四部分学时记录"
        }
        
        setUpUI()
        if isHistory == false {
            loadData()
        }
    }
    
    func setUpUI() {
        tableHeaderView.addSubview(periodRecordHeaderView)
        self.periodRecordHeaderView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10).priority(.high)
            make.top.equalTo(4)
            make.bottom.equalTo(-2)
        }
        
        var wait = allStudy - valid
        if wait < 0 {
            wait = 0
        }
        periodRecordHeaderView.waitTrainLabel.text = "\(wait/45)学时\(wait%45)分"
        periodRecordHeaderView.qualifiedLabel.text = "\(valid/45)学时\(valid%45)分"
        
        self.view.addSubview(tableView)
        tableView.isShowPlaceHolderView = true
    }
    
    func loadData() {
        var params = [String : Any]()
        params["subject"] = part+1
        params["page"] = page
        MBProgressHUD.showWait("请稍后...")
        
        NetWorkRequest(.periodList(params: params), completion: { [weak self](result) -> (Void) in
            self?.tableView.mj_header.endRefreshing()
            self?.tableView.MJ_Footer.endRefreshing()
            let code = result.object(forKey: "code") as! Int
            if code == 0{
                if self?.page == 1 {
                    self?.dataSource.removeAll()
                }
                let dic = result.object(forKey: "data") as! NSDictionary
                let list = dic.object(forKey: "list") as! [Any]
                for data in list {
                    self?.dataSource.append(data)
                }
                
                self?.tableView.reloadData()
                if list.count < 10 {
                    self?.tableView.MJ_Footer.endRefreshingWithNoMoreData()
                }
            }else if code == 402 {
                UserDefaults.standard.removeObject(forKey: isLogin)
                UserDefaults.standard.removeObject(forKey: loginInfo)
                let loginVC = LoginViewController()
                loginVC.reLoginDelegate = self
                loginVC.isFirstLogin = false
                self?.present(loginVC, animated: true, completion: nil)
            }
        }) { [weak self](error) -> (Void) in
            self?.tableView.mj_header.endRefreshing()
            self?.tableView.MJ_Footer.endRefreshing()
        }
    }
    
    func loadHistoryData() {
        var params = [String : Any]()
        params["subject"] = part+1
        params["page"] = page
        MBProgressHUD.showWait("请稍后...")
        NetWorkRequest(.periodHistoryList(params: params), completion: { [weak self](result) -> (Void) in
            self?.tableView.mj_header.endRefreshing()
            self?.tableView.MJ_Footer.endRefreshing()
            let code = result.object(forKey: "code") as! Int
            if code == 0{
                if self?.page == 1 {
                    self?.dataSource.removeAll()
                }
                let dic = result.object(forKey: "data") as! NSDictionary
                let list = dic.object(forKey: "list") as! [Any]
                for data in list {
                    self?.dataSource.append(data)
                }
                self?.tableView.reloadData()
                if list.count < 10 {
                    self?.tableView.MJ_Footer.endRefreshingWithNoMoreData()
                }
            }else if code == 402 {
                UserDefaults.standard.removeObject(forKey: isLogin)
                UserDefaults.standard.removeObject(forKey: loginInfo)
                let loginVC = LoginViewController()
                loginVC.reLoginDelegate = self
                loginVC.isFirstLogin = false
                self?.present(loginVC, animated: true, completion: nil)
            }
        }) { [weak self](error) -> (Void) in
            self?.tableView.mj_header.endRefreshing()
            self?.tableView.MJ_Footer.endRefreshing()
        }
    }
    
    func reFreshData() {
        page = 1
        if isHistory == true {
            self.loadHistoryData()
        }else {
            self.loadData()
        }
    }
    
    func loadMoreData() {
        page += 1
        if isHistory == true {
            self.loadHistoryData()
        }else {
            self.loadData()
        }
    }
}

extension PeriodRecordViewController: UITableViewDelegate, ZLTableViewDataSource, ZLPlaceHolderDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PeriodRecordTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! PeriodRecordTableViewCell
        cell.accessoryType = .none
        cell.selectionStyle = .default
        if indexPath.row == 0 {
            cell.topLineView.isHidden = true
        }else {
            cell.topLineView.isHidden = false
        }
        let dic:NSDictionary? = self.dataSource[indexPath.row] as? NSDictionary
        if dic != nil {
            cell.setDicInfo(dicInfo:dic!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dicInfo:NSDictionary? = self.dataSource[indexPath.row] as? NSDictionary
        
        let periodRecordDetailVC = PeriodRecordDetailViewController()
        periodRecordDetailVC.dicInfo = dicInfo
        self.navigationController?.pushViewController(periodRecordDetailVC, animated: true)
    }
    
    func makePlaceHolderView(tableView: UITableView) -> UIView {
        let view = PeriodRecordNoDataView()
        if isHistory == true {
            view.freshButton.isHidden = false
        }else {
            view.titleLabel.text = "暂无数据"
            view.freshButton.isHidden = true
        }
        view.delegate = self
        return view
    }
    
    ///ZLPlaceHolderDelegate
    func emptyOverlayClicked() {
        loadHistoryData()
    }
}
