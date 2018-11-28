//
//  BaseWebViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/28.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class BaseWebViewController: BaseViewController {
    
    var urlStr : String = ""
    var titleStr : String = ""
    
    lazy var webView: UIWebView = {
        let webView = UIWebView()
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = title
        // Do any additional setup after loading the view.
        if urlStr != "" {
            webView.loadRequest(URLRequest(url: URL(string: urlStr)!))
        }
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(navigationBarHeight)
            make.bottom.equalTo(safeAreaBottomHeight)
        }
    }
}
