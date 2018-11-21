//
//  TrainningStatusIViewController.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/21.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class TrainningStatusIViewController: UIViewController {
    
    var dataSource = [String]()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = KBUIFont18
        label.text = "培训状态"
        label.textColor = MainTitleColor
        return label
    }()
    
    lazy var rightButton: BaseButton = {
        let button = BaseButton()
        button.setImage(UIImage.init(named: "btn_right_close"), for: .normal)
        button.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.font = KBUIFont16
        label.text = "培训状态的含义"
        label.textColor = MainTextColor
        return label
    }()
    
    lazy var tableHeaderView: UIView = {
        let tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: 44))
        
        return tableHeaderView
    }()
    
    let CellIdentifier = "TrainingStatusTableViewCell"
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
        tableView.register(TrainingStatusTableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setUpUI()
        loadData()
    }
    
    func loadData() {
        dataSource = ["","",""]
        self.tableView.reloadData()
    }
    
    func setUpUI() {
        
        self.view.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(10+statusHeight)
        }
        
        self.view.addSubview(rightButton)
        self.rightButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.titleLabel.snp.centerY)
            make.right.equalTo(-10)
            make.width.height.equalTo(36)
        }
        
        tableHeaderView.addSubview(tipLabel)
        self.tipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.bottom.equalToSuperview()
        }
        
        self.view.addSubview(tableView)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func rightButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TrainningStatusIViewController:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TrainingStatusTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! TrainingStatusTableViewCell
        cell.accessoryType = .none
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let periodRecordDetailVC = PeriodRecordDetailViewController()
        
        self.navigationController?.pushViewController(periodRecordDetailVC, animated: true)
    }
}
