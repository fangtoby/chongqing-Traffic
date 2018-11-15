//
//  MineInfoViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/15.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineInfoViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let CellIdentifier = "MineInfoControTableViewCell"
    
    lazy var tableview: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
        tableView.register(MineInfoControTableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        
        return tableView
    }()
    
    private lazy var dataSource: Array = {
        return ["头像","昵称","手机号","签名"]
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "个人资料"
        
        self.view.addSubview(self.tableview)
        self.tableview.snp.makeConstraints { (make) in
            make.top.equalTo(navigationBarHeight)
            make.bottom.equalTo(safeAreaBottomHeight)
            make.left.right.equalToSuperview()
        }
    }

}

extension MineInfoViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 50
        }else{
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MineInfoControTableViewCell = tableview.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! MineInfoControTableViewCell
        cell.accessoryType = .none
        cell.selectionStyle = .default
        cell.titleLabel.text = self.dataSource[indexPath.row]
        if indexPath.row == 0 {
            cell.userLogoImageView.isHidden = false
            cell.descLabel.isHidden = true
        }else {
            cell.userLogoImageView.isHidden = true
            cell.descLabel.isHidden = false
        }
        //            cell.textLabel?.text = "个人信息"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            //头像
            
            
        }else if indexPath.row == 1 {
            //昵称
            let chanceNickNameVC = MineChanceNickNameAndSignViewController()
            chanceNickNameVC.nickNameStr = "李某某"
            self.navigationController?.pushViewController(chanceNickNameVC, animated: true)
            
        }else if indexPath.row == 2{
            //手机号
            let chancePhoneNumberVC = MineChancePhoneNumberViewController()
            chancePhoneNumberVC.oldNumber = "18888888888"
            self.navigationController?.pushViewController(chancePhoneNumberVC, animated: true)
        }else {
            //签名
            let chanceSignVC = MineChanceNickNameAndSignViewController()
            chanceSignVC.changeType = 2
            self.navigationController?.pushViewController(chanceSignVC, animated: true)
        }
    }
}
