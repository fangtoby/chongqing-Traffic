//
//  MBProgressHUD+Extension.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/26.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD {
    //显示等待消息
    class func showWait(_ title: String) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.minSize = CGSize(width: 120, height: 120)
        if #available(iOS 9.0, *) {
            UIActivityIndicatorView.appearance(whenContainedInInstancesOf:[MBProgressHUD.self]).color = .white
        } else {
            // Fallback on earlier versions
            UIActivityIndicatorView.my_appearanceWhenContained(in: MBProgressHUD.self).color = .white
        }
        hud.label.text = " "
        hud.label.font = UIFont.systemFont(ofSize: 13)
        hud.detailsLabel.text = title
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 13)
        hud.detailsLabel.textColor = .white
        hud.bezelView.color = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.9)
        hud.removeFromSuperViewOnHide = true
    }
    
    //显示普通消息
    class func showInfo(_ title: String) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
//        hud.minSize = CGSize(width: 120, height: 120)
        hud.mode = .customView //模式设置为自定义视图
//        hud.customView = UIImageView(image: UIImage(named: "info")!) //自定义视图显示图片
        hud.label.text = title
        hud.label.font = UIFont.systemFont(ofSize: 13)
        hud.label.textColor = .white
        hud.bezelView.color = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.9)
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: 2)
    }
    
    //显示成功消息
    class func showSuccess(_ title: String) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.minSize = CGSize(width: 120, height: 120)
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "icon_requst_success")!) //自定义视图显示图片
        hud.label.text = " "
        hud.label.font = UIFont.systemFont(ofSize: 13)
        hud.detailsLabel.text = title
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 13)
        hud.detailsLabel.textColor = .white
        hud.bezelView.color = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.9)
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 2)
    }
    
    //显示失败消息
    class func showError(_ title: String) {
        let view = viewToShow()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.minSize = CGSize(width: 120, height: 120)
        hud.mode = .customView //模式设置为自定义视图
        hud.customView = UIImageView(image: UIImage(named: "icon_requst_error")!) //自定义视图显示图片
        hud.label.text = " "
        hud.label.font = UIFont.systemFont(ofSize: 13)
        hud.detailsLabel.text = title
        hud.detailsLabel.font = UIFont.systemFont(ofSize: 13)
        hud.detailsLabel.textColor = .white
        hud.bezelView.color = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.9)
        hud.removeFromSuperViewOnHide = true
        //HUD窗口显示1秒后自动隐藏
        hud.hide(animated: true, afterDelay: 2)
    }
    
    class func hide() {
        let view = viewToShow()
        self.hide(for: view, animated: true)
    }
    
    //获取用于显示提示框的view
    class func viewToShow() -> UIView {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windowArray = UIApplication.shared.windows
            for tempWin in windowArray {
                if tempWin.windowLevel == UIWindow.Level.normal {
                    window = tempWin;
                    break
                }
            }
        }
        return window!
    }
}
