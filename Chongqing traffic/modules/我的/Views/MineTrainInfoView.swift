//
//  MineTrainInfoView.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/18.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineTrainInfoView: UIView {
    
    //身份证号
    private lazy var codeTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = AssistTextColor
        tipLabel.text = "身份证号"
        return tipLabel
    }()
    
    lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = MainTitleColor
        label.text = "666 666 **** **** 6666"
        return label
    }()
    
    //报名驾校
    private lazy var schoolTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = AssistTextColor
        tipLabel.text = "报名驾校"
        return tipLabel
    }()
    
    lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = MainTitleColor
        label.text = "重庆xx驾校"
        return label
    }()
    
    //报名时间
    private lazy var dateTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = AssistTextColor
        tipLabel.text = "报名时间"
        return tipLabel
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = MainTitleColor
        label.text = "2018-08-15"
        return label
    }()
    
    //联系电话
    private lazy var phoneTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = AssistTextColor
        tipLabel.text = "联系电话"
        return tipLabel
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = MainTitleColor
        label.text = "188 **** 8888"
        return label
    }()
    
    //计时平台
    private lazy var platformTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = AssistTextColor
        tipLabel.text = "计时平台"
        return tipLabel
    }()
    
    lazy var platformLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = MainTitleColor
        label.text = "六六计时培训系统"
        return label
    }()
    
    //结业状态
    private lazy var statusTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = AssistTextColor
        tipLabel.text = "结业状态"
        return tipLabel
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = MainTitleColor
        label.text = "未结业"
        return label
    }()
    
    //正在培训
    private lazy var currentTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = AssistTextColor
        tipLabel.text = "正在培训"
        return tipLabel
    }()
    
    lazy var currentLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = MainTitleColor
        label.text = "未结业"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension MineTrainInfoView {
    func setUpUI() {
        //身份证号
        self.addSubview(codeTipLabel)
        self.codeTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(22)
        }
        
        self.addSubview(codeLabel)
        self.codeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.codeTipLabel.snp.right).offset(8)
            make.top.equalTo(self.codeTipLabel.snp.top)
//            make.height.greaterThanOrEqualTo(20)
        }
        
        //驾校
        self.addSubview(schoolTipLabel)
        self.schoolTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.codeLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(schoolLabel)
        self.schoolLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.codeLabel.snp.left)
            make.top.equalTo(self.schoolTipLabel.snp.top)
//            make.height.greaterThanOrEqualTo(20)
        }
        
        //报名时间
        self.addSubview(dateTipLabel)
        self.dateTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.schoolLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(dateLabel)
        self.dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.codeLabel.snp.left)
            make.top.equalTo(self.dateTipLabel.snp.top)
//            make.height.greaterThanOrEqualTo(20)
        }
        
        //联系电话
        self.addSubview(phoneTipLabel)
        self.phoneTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.dateLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(phoneLabel)
        self.phoneLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.codeLabel.snp.left)
            make.top.equalTo(self.phoneTipLabel.snp.top)
//            make.height.greaterThanOrEqualTo(20)
        }
        
        //计时平台
        self.addSubview(platformTipLabel)
        self.platformTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.phoneLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(platformLabel)
        self.platformLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.codeLabel.snp.left)
            make.top.equalTo(self.platformTipLabel.snp.top)
//            make.height.greaterThanOrEqualTo(20)
        }
        
        //结业状态
        self.addSubview(statusTipLabel)
        self.statusTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.platformLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(statusLabel)
        self.statusLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.codeLabel.snp.left)
            make.top.equalTo(self.statusTipLabel.snp.top)
//            make.height.greaterThanOrEqualTo(20)
        }
        
        //正在培训
        self.addSubview(currentTipLabel)
        self.currentTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.statusLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(currentLabel)
        self.currentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.codeLabel.snp.left)
            make.top.equalTo(self.currentTipLabel.snp.top)
//            make.height.greaterThanOrEqualTo(20)
        }
    }
}
