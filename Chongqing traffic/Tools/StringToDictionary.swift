//
//  StringToDictionary.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/13.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import Foundation

func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
    
    let jsonData:Data = jsonString.data(using: .utf8)!
    
    let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    if dict != nil {
        return dict as! NSDictionary
    }
    return NSDictionary()
}
