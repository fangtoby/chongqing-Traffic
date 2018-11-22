//
//  MineViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/5.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let CellIdentifier1 = "MineInfoTableViewCell"
    private let CellIdentifier2 = "MineTableViewCell"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        tableView.register(MineInfoTableViewCell.self, forCellReuseIdentifier: CellIdentifier1)
        tableView.register(MineTableViewCell.self, forCellReuseIdentifier: CellIdentifier2)
        
        return tableView
    }()
    
    lazy var loginOutButton: BaseButton = {
        let loginOutBtn = BaseButton()
        loginOutBtn.titleLabel?.font = KUIFont16
        loginOutBtn.setTitle("退出登录", for: .normal)
        loginOutBtn.setTitleColor(MainRedColor, for: .normal)
        loginOutBtn.layer.cornerRadius = 4
        loginOutBtn.layer.borderColor = UIColor.init(red: 219/255.0, green: 219/255.0, blue: 219/255.0, alpha: 1).cgColor
        loginOutBtn.layer.borderWidth = 1
        loginOutBtn.addTarget(self, action: #selector(loginOut), for: .touchUpInside)
        return loginOutBtn
    }()
    
    private lazy var dataSource: Array = {
        return [[ ],
                ["icon":"icon_my_train", "title": "我的培训信息", "desc":"正在培训：第一部分"],
                ["icon":"icon_my_ensure", "title": "我的保障信息", "desc":"保障中"]]
    }()
    
    var userInfoDic:NSDictionary?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel()
        titleLabel.text = "个人中心"
        titleLabel.textColor = MainTitleColor
        titleLabel.font = KBUIFont18
        titleLabel.frame = CGRect(x: 20, y: navigationBarHeight - 25 - (44 - 25)/2.0, width: KScreenWidth - 40, height: 25)
        self.navigationItem.titleView = titleLabel
        
        userInfoDic = UserDefaults.standard.object(forKey: userInfo) as? NSDictionary
        
        setUpUI()
    }
    
    func setUpUI() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationBarHeight)
            make.bottom.equalTo(tabBarHeight)
            make.left.right.equalToSuperview()
        }
        
        self.view.addSubview(loginOutButton)
        self.loginOutButton.snp.makeConstraints { (make) in
            make.left.height.equalTo(40)
            make.right.equalTo(-40)
            make.bottom.equalTo(-(20 + tabBarHeight))
        }
    }
    
    private func loadData(){
//        NetWorkRequest(.newFeeds(type: 2, clumId: "SUBJECT_SIX"), completion: { (res) -> (Void) in
//            print(res)
////            print("网络成功的数据")
//        }, failed: { (str) -> (Void) in
//            print("网络请求失败的数据(resultCode不为正确时)")
//        }) { () -> (Void) in
//            print("网络错误了")
//        }
    }
    
    ///退出登录
    @objc func loginOut() {
        let alertView = ZLAlertView()
        alertView.messegeLabel.text = " 您是否要退出当前账号？"
        alertView.isHidenTitle()
        alertView.showView()
        alertView.sureBtnClick = { [weak self] in
            var logoutParams = [String:Any]()
            logoutParams["token"] = UIDevice.current.identifierForVendor?.uuidString
            NetWorkRequest(.logout(params: logoutParams), completion: { (result) -> (Void) in
                UserDefaults.standard.removeObject(forKey: isLogin)
                let loginVC = LoginViewController()
                loginVC.isFirstLogin = true
                self?.present(loginVC, animated: true, completion: nil)
            }, failed: { (error) -> (Void) in
                
            })
        }
    }
}

extension MineViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 105
        }else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell:MineInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier1, for: indexPath) as! MineInfoTableViewCell
            cell.accessoryType = .none
            cell.selectionStyle = .default
            let logoImageUrl = userInfoDic?.object(forKey: "photourl") as? String
            let logoUrl = URL(string: logoImageUrl ?? "")
            
//            cell.mineInfoView.userLogoImageView.kf.setImage(with: logoUrl)
            cell.mineInfoView.userLogoImageView.kf.setImage(with: logoUrl, placeholder: UIImage.init(named: "pic1.jpeg"), options: nil, progressBlock: nil, completionHandler: nil)
            cell.mineInfoView.nameLabel.text = userInfoDic?.object(forKey: "name") as? String
            let sex:Int = userInfoDic?.object(forKey: "sex") as! Int
            if sex == 2{
                cell.mineInfoView.sexImageView.image = UIImage.init(named: "icon_sex_woman")
            }else {
                cell.mineInfoView.sexImageView.image = UIImage.init(named: "icon_sex_man")
            }
            return cell
        }else {
            let cell:MineTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier2, for: indexPath) as! MineTableViewCell
            cell.accessoryType = .none
            cell.selectionStyle = .default
            if indexPath.row == 1 {
                cell.topLineView.isHidden = true
            }else {
                cell.topLineView.isHidden = false
            }
            let dict: [String: String] = dataSource[indexPath.row] as! [String : String]
            cell.setDicInfo(dicInfo: dict as NSDictionary)
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            //个人信息
            let userInfoVC = MineInfoViewController()
            self.navigationController?.pushViewController(userInfoVC, animated: true)
        }else if indexPath.row == 1 {
            //培训信息
            let trainInfoVC = MineTrainInfoViewController()
            self.navigationController?.pushViewController(trainInfoVC, animated: true)
        }else {
            //保障信息
            let ensureVC = MineEnsureViewController()
            self.navigationController?.pushViewController(ensureVC, animated: true)
        }
    }
}
