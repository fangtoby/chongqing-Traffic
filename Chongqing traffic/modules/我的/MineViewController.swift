//
//  MineViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/5.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var newFeeds = [FeedsModel]()
    
    private var argCon: Int = 0
    private var argName: String?
    private var argValue: Int = 0
    private var page: Int = 1
    private var spinnerName: String = ""
    
    private let CellIdentifier = "MineTableViewCell"
    private let HeaderIdentifier = "MineHeaderView"
    
    lazy var tableview: UITableView = {
        let tableView = UITableView.init(frame: self.view.bounds, style: UITableView.Style.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        tableView.register(MineTableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView.register(MineHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderIdentifier)
        
//        tableView.MJ_Header = RefreshHeader { [weak self] in self?.loadData() }
//        tableView.MJ_Footer = RefreshFooter { [weak self] in self?.loadData() }
        
        return tableView
    }()
    
    private lazy var dataSource: Array = {
        return [[["icon":"mine_accout", "title": "消费记录"],
                 ["icon":"mine_seal", "title": "我的封印图"]],
                
                [["icon":"mine_message", "title": "我的消息/优惠券"],
                 ["icon":"mine_freed", "title": "在线阅读免流量"]],
                
                [["icon":"mine_feedBack", "title": "帮助中心"],
                 ["icon":"mine_mail", "title": "我要反馈"],
                 ["icon":"mine_judge", "title": "给我们评分"],
                 ["icon":"mine_author", "title": "成为作者"],
                 ["icon":"mine_setting", "title": "退出有妖气"]]]
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navBarBackgroundAlpha = 0
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableview)
    }
    
    private func loadData(){
        NetWorkRequest(.newFeeds(type: 2, clumId: "SUBJECT_SIX"), completion: { (res) -> (Void) in
            print(res)
//            print("网络成功的数据")
        }, failed: { (str) -> (Void) in
            print("网络请求失败的数据(resultCode不为正确时)")
        }) { () -> (Void) in
            print("网络错误了")
        }
    }
}

extension MineViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 280
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView:MineHeaderFooterView = tableview.dequeueReusableHeaderFooterView(withIdentifier: HeaderIdentifier) as! MineHeaderFooterView
            return headerView
        }
        
        let view: UIView = {
            let view = UIView.init()
            return view
        }()
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MineTableViewCell = tableview.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! MineTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .default
        let sectionArray = dataSource[indexPath.section]
        let dict: [String: String] = sectionArray[indexPath.row]
        cell.imageView?.image =  UIImage(named: dict["icon"] ?? "")
        cell.textLabel?.text = dict["title"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 2 && indexPath.row == 4  {
            UserDefaults.standard.removeObject(forKey: isLogin)
            let loginVC = LoginViewController()
            loginVC.isFirstLogin = false
            self.present(loginVC, animated: true, completion: nil)
//            self.dismiss(animated: true, completion: nil)
        }
    }
}
