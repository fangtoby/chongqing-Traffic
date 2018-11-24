//
//  ComplaintSelectObjectView.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/18.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

// 创建闭包
typealias ComplaintObjectClick = ((String?) -> (Void))

class ComplaintSelectObjectView: UIView {
    
    var complaintObjectClick : ComplaintObjectClick?
    
    
    private let CellIdentifier = "MineInfoTableViewCell"
    
    var dataSource:[String]? = ["教练","驾校"]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setData(data: [String]) {
        self.dataSource = data
        self.tableView.snp.updateConstraints { (make) in
            make.height.equalTo(data.count*50)
        }
        self.tableView.reloadData()
        showView()
    }
    
    /// 显示view
    func showView() {
        UIApplication.shared.keyWindow?.addSubview(self)
        backgroundColor = UIColor.clear
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = UIColor().hexStringToColor(hexString: "0x000000", alpha: 0.3)
        }
    }
    
    /// 隐藏View
    func hideView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = UIColor.clear
            
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
}

extension ComplaintSelectObjectView {
    func setUpUI() {
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        self.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeigth)
        self.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.height.equalTo((self.dataSource?.count ?? 0)*50)
            make.height.greaterThanOrEqualTo(100)
        }
    }
}

extension ComplaintSelectObjectView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        cell.accessoryType = .none
        cell.selectionStyle = .default
        cell.textLabel?.text = self.dataSource?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let complaintObjectClick = complaintObjectClick else { return }
        complaintObjectClick(dataSource?[indexPath.row])
    }
}
