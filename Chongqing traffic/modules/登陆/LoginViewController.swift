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
            UserDefaults.standard.set(true, forKey: isLogin)
            if self!.isFirstLogin {
                let tabbarController = ESTabBarController()
                let v1 = PeriodSearchViewController()
                let v2 = MineViewController()
                
                v1.tabBarItem = ESTabBarItem.init(BasicContentView(), title: "培训学时", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"), tag: 0)
                v2.tabBarItem = ESTabBarItem.init(BasicContentView(), title: "个人中心", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"), tag: 1)
                
                
                let nav1 = BaseNavigationViewController.init(rootViewController: v1)
                let nav2 = BaseNavigationViewController.init(rootViewController: v2)
                
                tabbarController.viewControllers = [nav1,nav2]
                self?.present(tabbarController, animated: true, completion: nil)
            }else {
                self?.dismiss(animated: true, completion: nil)
            }
            
        }
        
        self.loginInfoView.selectDriving = {[weak self]() in
            
            
        }
    }
}
