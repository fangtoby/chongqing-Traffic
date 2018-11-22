//
//  LoginViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/6.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class LoginViewController: UIViewController {
    
    var isFirstLogin:Bool = true
    
    lazy var loginScrollView: UIScrollView = {
        let loginScrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeigth))
        loginScrollView.showsVerticalScrollIndicator = false
        loginScrollView.showsHorizontalScrollIndicator = false
//        loginScrollView.bounces = false
        return loginScrollView
    }()

    lazy var loginContentView: UIView = {
        let loginContentView = UIView()
        
        return loginContentView
    }()
    
    lazy var loginHeaderView : LoginHeaderView = {
       let loginHeaderView = LoginHeaderView.init(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 200))
        return loginHeaderView
    }()
    
    lazy var loginInfoView : LoginInfoView = {
        let loginInfoView = LoginInfoView.init(frame: CGRect(x: 0, y: 200, width: KScreenWidth, height: 500))
        return loginInfoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setUpUI()
        loadCodeData()
    }
    
    //获取验证码
    func loadCodeData() {
        let codeParams = [String:Any]()
        NetWorkRequest(.code(params: codeParams)) { [weak self](result) -> (Void) in
            self?.loginInfoView.loginCodeButton.setBackgroundImage(UIImage.init(data: result), for: .normal)
        }
    }
}

extension LoginViewController {
    func setUpUI() {
        self.view.addSubview(loginScrollView)
        self.loginScrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.loginScrollView.addSubview(self.loginContentView)
        self.loginContentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.bottom.equalTo(self.loginScrollView)
        }
        
        self.loginContentView.addSubview(loginHeaderView)
        self.loginHeaderView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.loginContentView)
            make.bottom.equalTo(loginHeaderView.titleLabel.snp.bottom)
        }
        
        self.loginContentView.addSubview(loginInfoView)
        self.loginInfoView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.loginContentView)
            make.top.equalTo(self.loginHeaderView.snp.bottom)
            make.bottom.equalTo(loginInfoView.loginTipLabel.snp.bottom).offset(30)
        }
        
        self.loginInfoView.loginBtnClick = {[weak self]() in
            UserDefaults.standard.set(self?.loginInfoView.loginPhoneTextField.text, forKey: "loginPhone")
            var loginParams = [String:Any]()
            loginParams["phone"] = self?.loginInfoView.loginPhoneTextField.text
            loginParams["cardCode"] = self?.loginInfoView.loginNumberTextField.text
            loginParams["drivingPermitted"] = self?.loginInfoView.loginDrivingTypeLabel.text
            loginParams["code"] = self?.loginInfoView.loginCodeTextField.text
            
            NetWorkRequest(.login(params: loginParams), completion: { (result) -> (Void) in

                //登陆成功的信息
                let loginInfoDic:NSDictionary = result.object(forKey: "data") as! NSDictionary
                print(loginInfoDic)
//                UserDefaults.standard.set(loginInfoDic, forKey: loginInfo)
                
                let userInfoParams = [String:Any]()
                NetWorkRequest(.studentInfo(params: userInfoParams), completion: { [weak self](result) -> (Void) in
                    UserDefaults.standard.set(true, forKey: isLogin)
                    //用户信息
                    let userInfoDic:NSDictionary = result.object(forKey: "data") as! NSDictionary
                    print(userInfoDic)
                    UserDefaults.standard.set(userInfoDic, forKey: userInfo)
                    
                    if self?.isFirstLogin == false{
                        let newUser:Bool? = loginInfoDic.object(forKey: "newUser") as? Bool
                        if newUser == true {
                            let alertView = ZLAlertView()
                            alertView.titleLabel.text = "查询说明"
                            alertView.messegeLabel.text = "系统检测到您为2018年7月10日之前报名学员，即将跳转专属查询结果页。"
                            alertView.showView()
                            alertView.sureBtnClick = { [weak self] in
                                let tabbarController = ESTabBarController()
                                let v1 = PeriodSearchViewController()
                                let v2 = MineViewController()
                                
                                v1.tabBarItem = ESTabBarItem.init(BasicContentView(), title: "培训学时", image: UIImage(named: "home_search_normal"), selectedImage: UIImage(named: "home_search_select"), tag: 0)
                                v2.tabBarItem = ESTabBarItem.init(BasicContentView(), title: "个人中心", image: UIImage(named: "home_usercenter_nomal"), selectedImage: UIImage(named: "home_usercenter_select"), tag: 1)
                                
                                let nav1 = BaseNavigationViewController.init(rootViewController: v1)
                                let nav2 = BaseNavigationViewController.init(rootViewController: v2)
                                
                                tabbarController.viewControllers = [nav1,nav2]
                                tabbarController.tabBar.barTintColor = UIColor.white
                                self?.present(tabbarController, animated: true, completion: nil)
                            }
                        }else {
                            let tabbarController = ESTabBarController()
                            let v1 = PeriodSearchViewController()
                            let v2 = MineViewController()
                            
                            v1.tabBarItem = ESTabBarItem.init(BasicContentView(), title: "培训学时", image: UIImage(named: "home_search_normal"), selectedImage: UIImage(named: "home_search_select"), tag: 0)
                            v2.tabBarItem = ESTabBarItem.init(BasicContentView(), title: "个人中心", image: UIImage(named: "home_usercenter_nomal"), selectedImage: UIImage(named: "home_usercenter_select"), tag: 1)
                            
                            let nav1 = BaseNavigationViewController.init(rootViewController: v1)
                            let nav2 = BaseNavigationViewController.init(rootViewController: v2)
                            
                            tabbarController.viewControllers = [nav1,nav2]
                            tabbarController.tabBar.barTintColor = UIColor.white
                            self?.present(tabbarController, animated: true, completion: nil)
                        }
                    }else {
                        self?.dismiss(animated: true, completion: nil)
                    }
                })
            })
        }
        
        self.loginInfoView.selectDriving = {[weak self]() in
            
            self?.view.endEditing(true)
            let pickerView = DrivingTypePickerView()
            if self?.loginInfoView.loginDrivingTypeLabel.text != "请选择培训车型" {
                pickerView.selectedDrivingType = self?.loginInfoView.loginDrivingTypeLabel.text
            }
            pickerView.drivingTypePickerViewWithDrivingTypeBlock(drivingTypeBlock: { (drivingType) in
                self?.loginInfoView.loginDrivingTypeLabel.text = drivingType
                self?.loginInfoView.loginDrivingTypeLabel.textColor = MainTextColor
            })
            /// 设置pickerView字体颜色和大小
            pickerView.pickerLabelFont = UIFont.systemFont(ofSize: 20)
            pickerView.pickerLabelTextCoclor = MainTextColor
        }
        
        self.loginInfoView.getLoginCode = { [weak self] in
            self?.loadCodeData()
        }
    }
}
