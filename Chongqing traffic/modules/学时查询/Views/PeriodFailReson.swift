//
//  PeriodFailReson.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/23.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import Foundation

func faildReason(index:String) -> String {
    var reasonStr : String
    switch index {
    case "1":
        reasonStr = "1：同一教练员同时带教多名学员!"
    case "2":
        reasonStr = "2：同一计时终端同时多人培训!"
    case "3":
        reasonStr = "3：同一学员在不同车上同时培训!"
    case "4":
        reasonStr = "4：该分钟学时产生的位置不在审核教学区域内!"
    case "5":
        reasonStr = "5：该学员单日培训时长已超过单日培训最大时长!"
    case "6":
        reasonStr = "6：最大行驶速度为0、发动机转速为0,同时出现并超过5分钟!"
    case "7":
        reasonStr = "7：行驶距离为0，出现并超过5分钟!"
    case "8":
        reasonStr = "8：过程照片人脸比对不通过！"
    case "9":
        reasonStr = "9：该学时不在有效培训时间段内!"
    case "10":
        reasonStr = "10：该电子教学日志找不到所对应的分钟学时!"
    case "11":
        reasonStr = "11：登录（或者登出）照片缺失!"
    case "12":
        reasonStr = "12：教练员审核未通过!"
    case "13":
        reasonStr = "13：教练车审核未通过!"
    case "14":
        reasonStr = "14：登录或登出照片人脸比对不通过！"
    case "15":
        reasonStr = "15：该学员单次培训时长小于设定值！"
    case "16":
        reasonStr = "16：发动机转速为0，并同时出现*分钟"
    case "17":
        reasonStr = "17：最大速度为0，并同时出现*分钟"
    case "18":
        reasonStr = "18：教学区域不存在"
    case "19":
        reasonStr = "19：定位时间不能为空"
    case "20":
        reasonStr = "20：过程照片缺失"
    case "21":
        reasonStr = "21：登入或登出照片缺失或时间不在规定时间段内！"
    case "51":
        reasonStr = "51：培训总学时未达标！"
    case "52":
        reasonStr = "52：培训总里程未达标！"
    case "53":
        reasonStr = "53：课堂培训不够规定时间！"
    case "54":
        reasonStr = "54：实车培训不够规定时间！"
    case "55":
        reasonStr = "55：远程教学不够规定时间！"
    case "56":
        reasonStr = "56：模拟器教学不够规定时间！"
    
    default:
        reasonStr = ""
    }
    
    return reasonStr
}

