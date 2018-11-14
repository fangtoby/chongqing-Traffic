//
//  UserDefaults.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/7.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import Foundation

extension UserDefaults {
    subscript (key:String) -> NSObject? {
        get {
            return (object(forKey: key) as! NSObject)
        }
        set {
            set(newValue, forKey: key)
        }
    }
}
