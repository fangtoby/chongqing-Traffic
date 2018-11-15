//
//  PeriodSearchViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/5.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class PeriodSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(white: 255/255.0, alpha: 1)
        
        let titleLabel = UILabel()
        titleLabel.text = "培训学时"
        titleLabel.textColor = MainTitleColor
        titleLabel.font = KBUIFont18
        titleLabel.frame = CGRect(x: 20, y: navigationBarHeight - 25 - (44 - 25)/2.0, width: KScreenWidth - 40, height: 25)
        self.navigationItem.titleView = titleLabel
        // Do any additional setup after loading the view.
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
