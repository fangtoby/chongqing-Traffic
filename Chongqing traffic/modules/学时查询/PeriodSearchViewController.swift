//
//  PeriodSearchViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/5.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit
import DNSPageView

class PeriodSearchViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel()
        titleLabel.text = "培训学时"
        titleLabel.textColor = MainTitleColor
        titleLabel.font = KBUIFont18
        titleLabel.frame = CGRect(x: 20, y: navigationBarHeight - 25 - (44 - 25)/2.0, width: KScreenWidth - 40, height: 25)
        self.navigationItem.titleView = titleLabel
        
        // 创建DNSPageStyle，设置样式
        let style = DNSPageStyle()
        
        style.titleColor = MainTitleColor
        style.titleSelectedColor = MainYellowColor
        style.titleFont = KUIFont16
        style.isShowBottomLine = true
        style.bottomLineColor = MainYellowColor
        
        let titles = ["第一部分","第二部分","第三部分","第四部分"]
        let viewControllers:[UIViewController] = [OnePeriodViewController(),OnePeriodViewController(),OnePeriodViewController(),OnePeriodViewController()]
        for vc in viewControllers{
            self.addChild(vc)
        }
        let pageView = DNSPageView(frame: CGRect(x: 0, y: navigationBarHeight, width: KScreenWidth, height: KScreenHeigth-navigationBarHeight - tabBarHeight - 44), style: style, titles: titles, childViewControllers: viewControllers)
        view.addSubview(pageView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
