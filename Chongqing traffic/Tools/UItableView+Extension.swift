//
//  UItableView+Extension.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/19.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit
import Foundation

@objc protocol ZLTableViewDataSource: class, UITableViewDataSource {
    @objc optional func makePlaceHolderView(tableView: UITableView) -> UIView
}

extension UITableView:placeHolderProtocol {
    
    static var showPlaceHolderView = "isShowPlaceHolderView"
    static var placeHolderView = "placeHolderView"
    var isShowPlaceHolderView: Bool {
        set {
            objc_setAssociatedObject(self, &UITableView.showPlaceHolderView, newValue,.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            if let rs = objc_getAssociatedObject(self, &UITableView.showPlaceHolderView) as? Bool {
                return rs
            }
            return false
        }
    }
    
    var placeHolderView:UIView? {
        set {
            objc_setAssociatedObject(self, &UITableView.placeHolderView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &UITableView.placeHolderView) as? UIView
        }
    }
    
    private static let onceToken = UUID().uuidString
    public static func initializeMethod()
    {
        DispatchQueue.once(token: onceToken)
        {
            let originalSelector = #selector(UITableView.reloadData)
            let swizzledSelector = #selector(self.zl_reloadData)
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            //在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
            let didAddMethod: Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
            //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
            
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
            } else {
                method_exchangeImplementations(originalMethod!, swizzledMethod!)
            }
        }
    }
    
    @objc func zl_reloadData() {
        self.zl_reloadData()
        if isShowPlaceHolderView == true {
            zl_checkEmpty()
        }
    }
    
    func zl_checkEmpty() {
        guard dataSource != nil else {
            return
        }

        guard dataSource is ZLTableViewDataSource else {
            return
        }
        
        var isEmpty:Bool = true

        let src:ZLTableViewDataSource? = self.dataSource as? ZLTableViewDataSource
        var sections = 1
        if src?.responds(to: #selector(getter: numberOfSections)) != nil {
            sections = (src?.numberOfSections!(in: self))!
        }

        for i in 0..<sections {
            let rows = src?.tableView(self, numberOfRowsInSection: i)
            if rows != nil, rows! > 0 {
                isEmpty = false
                break
            }
        }

        if (self.placeHolderView) != nil {
            self.placeHolderView?.removeFromSuperview()
            self.placeHolderView = nil
        }

        if (isEmpty) {
            if (src?.responds(to: #selector(src?.makePlaceHolderView(tableView:))))! {
                self.placeHolderView = src?.makePlaceHolderView!(tableView: self)
            }
            
            var headerViewHeight:CGFloat = 0
            if self.tableHeaderView != nil {
                headerViewHeight = self.tableHeaderView?.frame.size.height ?? 0
            }
            
            self.placeHolderView?.frame = CGRect.init(x: 0, y: headerViewHeight, width: self.frame.size.width, height: self.frame.size.height - headerViewHeight)
            self.addSubview(self.placeHolderView!)
        } else {
            self.placeHolderView?.removeFromSuperview()
            self.placeHolderView = nil
        }
    }
}

// 1. 定义 协议
public protocol placeHolderProtocol: class {
    static func initializeMethod()
}

