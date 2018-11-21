//
//  MineEnsureDetailView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/20.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineEnsureDetailView: UIView {

    //培训车型
    private lazy var trainTypeTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "培训车型"
        return tipLabel
    }()
    lazy var trainTypeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.text = "C1"
        return label
    }()
    
    //理赔卡号
    private lazy var cardCodeTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "赔付卡号"
        return tipLabel
    }()
    lazy var cardCodeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.text = "招商银行  尾号1236"
        return label
    }()
    
    //理赔状态
    private lazy var statusTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "理赔状态"
        return tipLabel
    }()
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.text = "理赔中"
        return label
    }()
    
    //理赔记录
    private lazy var recordTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "理赔记录"
        return tipLabel
    }()
    
    let CellIdentifier = "PaymentRecordCell"
    lazy var recordTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
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
}

extension MineEnsureDetailView {
    func setUpUI() {
        self.addSubview(trainTypeTipLabel)
        self.trainTypeTipLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(40)
        }
        
        self.addSubview(trainTypeLabel)
        self.trainTypeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.trainTypeTipLabel.snp.right).offset(8)
            make.centerY.equalTo(self.trainTypeTipLabel.snp.centerY)
        }
        
        self.addSubview(cardCodeTipLabel)
        self.cardCodeTipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.trainTypeLabel.snp.bottom).offset(10)
            make.left.equalTo(self.trainTypeTipLabel.snp.left)
        }
        
        self.addSubview(cardCodeLabel)
        self.cardCodeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.trainTypeLabel.snp.left)
            make.centerY.equalTo(self.cardCodeTipLabel.snp.centerY)
        }
        
        self.addSubview(statusTipLabel)
        self.statusTipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.cardCodeLabel.snp.bottom).offset(10)
            make.left.equalTo(self.trainTypeTipLabel.snp.left)
        }
        
        self.addSubview(statusLabel)
        self.statusLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.trainTypeLabel.snp.left)
            make.centerY.equalTo(self.statusTipLabel.snp.centerY)
        }
        
        self.addSubview(recordTipLabel)
        self.recordTipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.statusLabel.snp.bottom).offset(10)
            make.left.equalTo(self.trainTypeTipLabel.snp.left)
        }
        
        self.addSubview(recordTableView)
        self.recordTableView.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.bottom.equalToSuperview()
            make.top.equalTo(self.recordTipLabel.snp.bottom).offset(4)
        }
    }
}

extension MineEnsureDetailView : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        cell.accessoryType = .none
        cell.selectionStyle = .none
        cell.textLabel?.font = KUIFont14
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = "2018年10月31日  待保险公司确认"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 28
    }
}
