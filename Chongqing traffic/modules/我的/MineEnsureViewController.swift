//
//  MineEnsureViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/20.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class MineEnsureViewController: BaseViewController {
    
    var dataSource = [Any]()
    var isFromPay = false
    
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
        tableView.MJ_Header = DIYFreshHeader { [weak self] in self?.reFreshData() }
        tableView.register(MineEnsureOrderTableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFromPay == true {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "我的保障信息"
        if isFromPay == true {
            let backBtn = UIButton()
            backBtn.setTitle(" 返回", for: .normal)
            backBtn.setImage(UIImage(named: "btn_back"), for: .normal)
            backBtn.setTitleColor(MainTitleColor, for: .normal)
            backBtn.titleLabel?.font = KUIFont16
            backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
            
            let leftBtnItem = UIBarButtonItem.init(customView: backBtn)
            self.navigationItem.leftBarButtonItem = leftBtnItem
        }
        
        setUpUI()
    }
    
    func loadData() {
        let params = [String : Any]()
        
        NetWorkRequest(.insuranceOrderList(params: params), completion: { [weak self](result) -> (Void) in
            self?.tableView.mj_header.endRefreshing()
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
        }) { [weak self](error) -> (Void) in
            self?.tableView.mj_header.endRefreshing()
        }
    }
    
    func reFreshData() {
        //先判断网络是否有链接 没有的话直接返回--代码略
        if !isNetworkConnect{
            print("提示用户网络似乎出现了问题")
            MBProgressHUD.showInfo("网络似乎出现了问题")
            tableView.mj_header.endRefreshing()
            return
        }
        self.loadData()
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
        //购买保险
        let insuranceVC = InsuranceViewController()
        insuranceVC.isBuyFromList = true
        self.navigationController?.pushViewController(insuranceVC, animated: true)
    }
    
    override func reLogin() {
        loadData()
    }
    
    @objc func back() {
        self.navigationController?.popToRootViewController(animated: true)
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
        if payStatus == "UNPAID" {
            //去支付
            let insurancePayVC = InsurancePayViewController()
            insurancePayVC.orderId = orderId ?? 0
            insurancePayVC.isFromList = true
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
