//
//  PeriodRecordHeaderView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/16.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class PeriodRecordHeaderView: UIView {
    
    lazy var waitTrainLabel: UILabel = {
        let waitTrainLabel = UILabel()
        waitTrainLabel.font = KBUIFont20
        waitTrainLabel.textColor = UIColor(r: 245, g: 166, b: 35)
        waitTrainLabel.text = "1学时21分"
        return waitTrainLabel
    }()
    
    lazy var waitTrainTipLabel: UILabel = {
        let waitTrainTipLabel = UILabel()
        waitTrainTipLabel.font = KUIFont12
        waitTrainTipLabel.textColor = AssistColor
        waitTrainTipLabel.text = "待培训学时"
        return waitTrainTipLabel
    }()
    
    lazy var qualifiedLabel: UILabel = {
        let qualifiedLabel = UILabel()
        qualifiedLabel.font = KBUIFont20
        qualifiedLabel.textColor = MainBlueColor
        qualifiedLabel.text = "15学时06分"
        return qualifiedLabel
    }()
    
    lazy var qualifiedTipLabel: UILabel = {
        let qualifiedTipLabel = UILabel()
        qualifiedTipLabel.font = KUIFont12
        qualifiedTipLabel.textColor = AssistColor
        qualifiedTipLabel.text = "15学时06分"
        return qualifiedTipLabel
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI() {
        addSubview(waitTrainLabel)
        self.waitTrainLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().dividedBy(2)
            make.top.equalTo(20)
            make.height.equalTo(28)
        }
        
        addSubview(waitTrainTipLabel)
        self.waitTrainTipLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.waitTrainLabel.snp.centerX)
            make.top.equalTo(self.waitTrainLabel.snp.bottom).offset(10)
        }
        
        addSubview(qualifiedLabel)
        self.qualifiedLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().multipliedBy(1.5)
            make.top.equalTo(20)
            make.height.equalTo(28)
        }
        
        addSubview(qualifiedTipLabel)
        self.qualifiedTipLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.qualifiedLabel.snp.centerX)
            make.top.equalTo(self.qualifiedLabel.snp.bottom).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
