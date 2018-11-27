//
//  MineEnsureViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/20.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineEnsureViewController: BaseViewController {
    
    var dataSource = [Any]()
    
    
    lazy var buyBtn: BaseButton = {
        let button = BaseButton()
        button.titleLabel?.font = KUIFont16
        button.setTitle("新购保障", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MainTitleColor
        button.addTarget(self, action: #selector(buyInsuranceClicked), for: .touchUpInside)
        return button
    }()

    let CellIdentifier = "MineEnsureOrderTableViewCell"
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: navigationBarHeight, width: KScreenWidth, height: KScreenHeigth - navigationBarHeight))
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isShowPlaceHolderView = true
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
        tableView.register(MineEnsureOrderTableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的保障信息"
        setUpUI()
        
        loadData()
    }
    
    func loadData() {
        let params = [String : Any]()
        
        NetWorkRequest(.insuranceOrderList(params: params), completion: { [weak self](result) -> (Void) in
            let code = result.object(forKey: "code") as! Int
            if code == 0 {
                
                self?.dataSource = result.object(forKey: "data") as! [Any]
                self?.tableView.reloadData()
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
        self.view.addSubview(buyBtn)
        self.buyBtn.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.bottom.equalTo(-(40 + safeAreaBottomHeight))
            make.height.equalTo(40)
        }
        
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(navigationBarHeight)
            make.bottom.equalTo(self.buyBtn.snp.top).offset(-20)
        }
    }
    
    @objc func buyInsuranceClicked () {
        let insuranceVC = InsuranceViewController()
        self.navigationController?.pushViewController(insuranceVC, animated: true)
    }
    
    override func reLogin() {
        loadData()
    }
}

extension MineEnsureViewController:UITableViewDelegate, UITableViewDataSource, ZLTableViewDataSource, ZLPlaceHolderDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MineEnsureOrderTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! MineEnsureOrderTableViewCell
        cell.accessoryType = .none
        cell.selectionStyle = .default
        let dicInfo:NSDictionary? = dataSource[indexPath.row] as? NSDictionary
        cell.setData(dicInfo:dicInfo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dicInfo = dataSource[indexPath.row] as? NSDictionary
        let orderId = dicInfo?.object(forKey: "orderId") as? Int
        
        let payStatus = dicInfo?.object(forKey: "orderStatus") as? String
        if payStatus == "REFUND" {
            //去支付
            let insurancePayVC = InsurancePayViewController()
            insurancePayVC.orderId = orderId ?? 0
            self.navigationController?.pushViewController(insurancePayVC, animated: true)
        }else {
            //订单详情
            let ensureDetailVC = MineEnsureDetailViewController()
            ensureDetailVC.orderId = orderId ?? 0
            self.navigationController?.pushViewController(ensureDetailVC, animated: true)
        }
    }
    
    func makePlaceHolderView(tableView: UITableView) -> UIView {
        let view = PeriodRecordNoDataView()
        view.freshButton.isHidden = false
        view.titleLabel.text = "暂无数据"
        view.delegate = self
        return view
    }
    
    ///ZLPlaceHolderDelegate
    func emptyOverlayClicked() {
        loadData()
    }
}
