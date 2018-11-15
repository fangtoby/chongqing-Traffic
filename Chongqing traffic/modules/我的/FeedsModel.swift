//
//  FeedsModel.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/12.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import Foundation
import HandyJSON

struct ExtModel: HandyJSON {
    var key: String?
    var val: String?
}

struct FeedsModel: HandyJSON {
    var id: Int = 0
    var linkType: Int = 0
    var cover: String?
    var ext: [ExtModel]?
    var title: String?
    var content: String?
}

struct NewFeedsModel: HandyJSON {
    var feeds: [FeedsModel]?
}
