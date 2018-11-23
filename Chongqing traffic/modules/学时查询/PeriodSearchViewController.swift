//
//  PeriodSearchViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/5.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class PeriodSearchViewController: BaseViewController {

    var pageView : ZLPageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "培训学时"
        titleLabel.textColor = MainTitleColor
        titleLabel.font = KBUIFont18
        titleLabel.frame = CGRect(x: 20, y: navigationBarHeight - 25 - (44 - 25)/2.0, width: KScreenWidth - 40, height: 25)
        self.navigationItem.titleView = titleLabel
        
        setUpUI()
        loadCurrentPart()
    }
    
    func loadCurrentPart() {
        let currentPartParams = [String:Any]()

        NetWorkRequest(.currentPart(params: currentPartParams), completion: { [weak self](result) -> (Void) in
            if result.valueAsString(forKey: "code") == nil {
                
                guard let part = result.valueAsString(forKey: "data") else { return }
                if Int(part)! > 0 {
                    self?.pageView?.currentIndex(index: Int(part)! - 1)
                }
                
            }else if result.valueAsString(forKey: "code") == "402" {
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
        //创建pageView
        let titles = ["第一部分","第二部分","第三部分","第四部分"]
        var childsVc:[UIViewController] = [UIViewController]()
        for i in 0..<titles.count {
            let contentVc = PeriodPartViewController()
            contentVc.part = i
            childsVc.append(contentVc)
        }
        
        let style = ZLPageStyle()
        style.labelHeight = 35
        style.labelMargin = 0
        style.labelFont = 16
        style.labelLayout = .divide
        style.selectColor = UIColor(r: 250, g: 190, b: 0)
        style.normalColor = UIColor(r: 65, g: 58, b: 57)
        style.titleBottomLineColor = UIColor(r: 250, g: 190, b: 0)
        style.isBottomAlginLabel = false
        pageView = ZLPageView(frame: CGRect(x: 0, y: navigationBarHeight, width: KScreenWidth, height: KScreenHeigth-navigationBarHeight - tabBarHeight), titles: titles, childControllers: childsVc, parentController: self, style: style)
        pageView?.delegate = self
        self.view.addSubview(pageView!)
    }
    
    override func reLogin() {
        loadCurrentPart()
    }
}

extension PeriodSearchViewController:PageViewDelegate {
    func currentSelect(selectIndex: Int) {
        
    }
}
