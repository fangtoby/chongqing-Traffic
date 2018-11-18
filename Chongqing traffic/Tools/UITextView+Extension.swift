//
//  UITextView+Extension.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/18.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit
import Foundation

private var key = "placeholderLabel"

extension UITextView {
    var placeholderLabel:UILabel?{
        get{
            var label:UILabel? = objc_getAssociatedObject(self, &key) as? UILabel
            if label == nil{
                let originalText:NSAttributedString=self.attributedText
                self.text=""
                self.attributedText = originalText
                label = UILabel()
                label?.textColor=UIColor.lightGray
                label?.numberOfLines=0
                label?.isUserInteractionEnabled=false
                //关联label属性
                objc_setAssociatedObject(self, &key, label, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                //KVO监听TextView各属性的变化，并更新placeholderLabel
                NotificationCenter.default.addObserver(self, selector: #selector(self.updatePlaceholderLabel), name:NSNotification.Name.init(rawValue: "UITextViewTextDidChange"), object: self)
                
                let observingKeys = ["attributedText","bounds","font","frame","textAlignment","textContainerInset"]
                for key in observingKeys {
                    //设置监听
                    self.addObserver(self, forKeyPath: key, options: .new, context:nil)
                }
                
                let hooker = DeallocHooker()
                //通过闭包判断TextView是否dealloc,在dealloc时移除监听
                hooker.deallocHandle = {[weak self] in
                    NotificationCenter.default.removeObserver(self)
                    for key in observingKeys {
                        self.removeObserver(self, forKeyPath: key)
                    }
                }
                objc_setAssociatedObject(self, &AssociatedKeys.deallocHooker, hooker, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return label
            }
        }
    }
    
    class DeallocHooker:NSObject{
        var deallocHandle:DeallocHooker?
        deinit {
            if deallocHandle != nil{
                deallocHandle!()
            }
        }
    }
    
    open override func observeValue(forKeyPath keyPath:String?, of object:Any?, change: [NSKeyValueChangeKey:Any]?, context:UnsafeMutableRawPointer?) {
        updatePlaceholderLabel()
    }
    
    @objc func updatePlaceholderLabel(){
        if self.text.count > 0{
            self.placeholderLabel?.removeFromSuperview()
            return
            
        }
        self.insertSubview(self.placeholderLabel!, at:0)
        self.placeholderLabel?.font = self.font
        self.placeholderLabel?.textAlignment = self.textAlignment
        let x = self.textContainer.lineFragmentPadding + self.textContainerInset.left
        let y = self.textContainerInset.top
        let width = (self.bounds.width - x - self.textContainer.lineFragmentPadding - self.textContainerInset.right)
        let height = self.placeholderLabel?.sizeThatFits(CGSize(width: width, height:0)).height
        self.placeholderLabel?.frame=CGRect(x: x, y: y, width: width, height: height!)
    }
}






