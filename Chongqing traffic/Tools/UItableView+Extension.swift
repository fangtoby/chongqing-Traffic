//
//  UItableView+Extension.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/19.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit
import Foundation

protocol placeHolderTableViewDelegate {
    func makePlaceHolderView() -> UIView
}

extension UITableView:placeHolderProtocol {
    
    static var showPlaceHolderView = "isShowPlaceHolderView"
    static var placeHolderView = "placeHolderView"
    var isShowPlaceHolderView: Bool {
        set {
            objc_setAssociatedObject(self, &UITableView.showPlaceHolderView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
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
            objc_setAssociatedObject(self, &UITableView.placeHolderView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
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
//        var isEmpty:Bool = true
//
//        let src:UITableViewDataSource? = self.dataSource
//        var sections = 1
//        if src?.responds(to: #selector(getter: numberOfSections)) != nil {
//            sections = (src?.numberOfSections!(in: self))!
//        }
//
//        for i in sections {
//            let rows = src?.tableView(self, numberOfRowsInSection: i)
//            if let rows = rows {
//                isEmpty = NO
//            }
//        }
//
//        for (int i = 0; i<sections; ++i) {
//            let rows = [src tableView:self numberOfRowsInSection:i];
//            if (rows) {
//                isEmpty = NO;
//            }
//        }
//
//        if (self.placeHolderView) {
//            self.scrollEnabled = self.scrollWasEnabled;
//            [self.placeHolderView removeFromSuperview];
//            self.placeHolderView = nil;
//        }
//
//        if (isEmpty) {
//            self.scrollWasEnabled = self.scrollEnabled;
//            BOOL scrollEnabled = NO;
//            if ([self respondsToSelector:@selector(enableScrollWhenPlaceHolderViewShowing)]) {
//                scrollEnabled = [self performSelector:@selector(enableScrollWhenPlaceHolderViewShowing)];
//                if (!scrollEnabled) {
//                    NSString *reason = @"There is no need to return  NO for `-enableScrollWhenPlaceHolderViewShowing`, it will be NO by default";
//                    @throw [NSException exceptionWithName:NSGenericException
//                        reason:reason
//                        userInfo:nil];
//                }
//            } else if ([self.delegate respondsToSelector:@selector(enableScrollWhenPlaceHolderViewShowing)]) {
//                scrollEnabled = [self.delegate performSelector:@selector(enableScrollWhenPlaceHolderViewShowing)];
//                if (!scrollEnabled) {
//                    NSString *reason = @"There is no need to return  NO for `-enableScrollWhenPlaceHolderViewShowing`, it will be NO by default";
//                    @throw [NSException exceptionWithName:NSGenericException
//                        reason:reason
//                        userInfo:nil];
//                }
//            }
//            self.scrollEnabled = scrollEnabled;
//            if ([self respondsToSelector:@selector(makePlaceHolderView)]) {
//                self.placeHolderView = [self performSelector:@selector(makePlaceHolderView)];
//            } else if ( [self.delegate respondsToSelector:@selector(makePlaceHolderView)]) {
//                self.placeHolderView = [self.delegate performSelector:@selector(makePlaceHolderView)];
//            } else {
//                NSString *selectorName = NSStringFromSelector(_cmd);
//                NSString *reason = [NSString stringWithFormat:@"You must implement makePlaceHolderView method in your custom tableView or its delegate class if you want to use %@", selectorName];
//                @throw [NSException exceptionWithName:NSGenericException
//                    reason:reason
//                    userInfo:nil];
//            }
//            //        self.placeHolderView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//            self.placeHolderView.frame = CGRectMake(0, self.tableHeaderView.frame.size.height, self.frame.size.width, self.frame.size.height - self.tableHeaderView.frame.size.height);
//            [self addSubview:self.placeHolderView];
//        } else {
//            self.scrollEnabled = self.scrollWasEnabled;
//            [self.placeHolderView removeFromSuperview];
//            self.placeHolderView = nil;
//        }
    }
}

// 1. 定义 协议
public protocol placeHolderProtocol: class {
    static func initializeMethod()
}

