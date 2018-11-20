//
//  PeriodRecordViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/16.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class PeriodRecordViewController: BaseViewController {
    var part : Int = 0
    var dataSource = [String]()
    var isFresh = false
    
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
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
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
        loadData()
    }
    
    func setUpUI() {
        tableHeaderView.addSubview(periodRecordHeaderView)
        self.periodRecordHeaderView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10).priority(.high)
            make.top.equalTo(4)
            make.bottom.equalTo(-2)
        }
        
        self.view.addSubview(tableView)
        tableView.isShowPlaceHolderView = true
    }
    
    func loadData() {
        if isFresh == true {
            dataSource = ["","","","","","","","",""]
        }
        
        self.tableView.reloadData()
    }
    
}

extension PeriodRecordViewController: UITableViewDelegate, ZLTableViewDataSource, ZLPlaceHolderDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let periodRecordDetailVC = PeriodRecordDetailViewController()
        
        self.navigationController?.pushViewController(periodRecordDetailVC, animated: true)
    }
    
    func makePlaceHolderView(tableView: UITableView) -> UIView {
        let view = PeriodRecordNoDataView()
        view.delegate = self
        return view
    }
    
    ///ZLPlaceHolderDelegate
    func emptyOverlayClicked() {
        //刷新数据
        self.isFresh = true
        loadData()
    }
}
