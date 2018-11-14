//
//  BaseNavigationViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/5.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNavBarAppearence()
    }
}

func setNavBarAppearence()
{
    // 设置导航栏默认的背景颜色
    WRNavigationBar.defaultNavBarBarTintColor = DominantColor
    // 设置导航栏所有按钮的默认颜色
    WRNavigationBar.defaultNavBarTintColor = .white
    // 设置导航栏标题默认颜色
    WRNavigationBar.defaultNavBarTitleColor = .white
    // 统一设置状态栏样式
    //        WRNavigationBar.defaultStatusBarStyle = .lightContent
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    WRNavigationBar.defaultShadowImageHidden = true
    
}
extension BaseNavigationViewController
{
    override func pushViewController(_ viewController: UIViewController, animated: Bool)
    {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
