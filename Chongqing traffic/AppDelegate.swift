//
//  AppDelegate.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/5.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

import ESTabBarController_swift
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enable = true;
        
        PayManager.instance.registerApplication()
        
        let isLoginStatus = UserDefaults.standard.object(forKey: isLogin)
        if (isLoginStatus != nil) {
            let tabbarController = ESTabBarController()
            let v1 = PeriodSearchViewController()
            let v2 = MineViewController()
            
            v1.tabBarItem = ESTabBarItem.init(BasicContentView(), title: "培训学时", image: UIImage(named: "home_search_normal"), selectedImage: UIImage(named: "home_search_select"), tag: 0)
            v2.tabBarItem = ESTabBarItem.init(BasicContentView(), title: "个人中心", image: UIImage(named: "home_usercenter_nomal"), selectedImage: UIImage(named: "home_usercenter_select"), tag: 1)
            
            let nav1 = BaseNavigationViewController.init(rootViewController: v1)
            let nav2 = BaseNavigationViewController.init(rootViewController: v2)
            
            v1.title = "培训学时"
            v2.title = "个人中心"
            
            tabbarController.viewControllers = [nav1,nav2]
            tabbarController.tabBar.barTintColor = UIColor.white
            self.window?.rootViewController = tabbarController
        }else {
            let loginVC = LoginViewController()
            self.window?.rootViewController = loginVC
        }

        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate {
    
   ///第三方应用跳转回调
    
    //最老的版本，最好也写上
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        
        return PayManager.instance.handleOpenURL(url: url)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return PayManager.instance.handleOpenURL(url: url)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return PayManager.instance.handleOpenURL(url: url)
    }
}

