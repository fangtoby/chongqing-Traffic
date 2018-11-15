//
//  PeriodSearchView.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/15.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class PeriodSearchView: UIView {
    
    lazy var progressView: UIView = {
        let progressView = UIView()
        progressView.backgroundColor = .gray
        return progressView
    }()
    
    lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.numberOfLines = 0
        tipLabel.font = KUIFont14
        tipLabel.textColor = AssistColor
        tipLabel.textAlignment = .center
        tipLabel.text = "本月有80.6%的学员\n无法一次性通过本科目考试"
        return tipLabel
    }()
    
    ///学习进度
    private var studyProgressLabel: UILabel = {
        let studyLabel = UILabel()
        studyLabel.font = KUIFont14
        studyLabel.textColor = AssistTextColor
        studyLabel.text = "学习进度"
        return studyLabel
    }()
    
    lazy var allStudyLabel: UILabel = {
        let allStudyLabel = UILabel()
        allStudyLabel.backgroundColor = KUIColorLine
        return allStudyLabel
    }()
    
    lazy var studyLabel: UILabel = {
        let studyLabel = UILabel()
        studyLabel.backgroundColor = UIColor.init(red: 105/255.0, green: 171/255.0, blue: 209/255.0, alpha: 1)
        return studyLabel
    }()
    
    lazy var percentLabel: UILabel = {
        let percentLabel = UILabel()
        percentLabel.font = KUIFont10
        percentLabel.textColor = UIColor.init(red: 105/255.0, green: 171/255.0, blue: 209/255.0, alpha: 1)
        percentLabel.text = "75%"
        return percentLabel
    }()
    
    ///培训时长
    private var trainTimeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = AssistTextColor
        label.text = "培训时长"
        return label
    }()
    
    lazy var trainLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = MainTitleColor
        label.text = "12小时20分钟"
        return label
    }()
    
    ///有效学时
    private var validTimeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = AssistTextColor
        label.text = "有效学时"
        return label
    }()
    
    lazy var validLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = MainTitleColor
        label.text = "12学时"
        return label
    }()
    
    lazy var validButton: UIButton = {
        let validBtn = UIButton()
        validBtn.setBackgroundImage(UIImage.init(named: "icon_link_web"), for: .normal)
        return validBtn
    }()
    
    ///培训状态
    private var trainStatusTitleLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = AssistTextColor
        label.text = "培训状态"
        return label
    }()
    
    lazy var trainStatusLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = MainTitleColor
        label.text = "未推送考试系统"
        return label
    }()
    
    lazy var trainStatusButton: UIButton = {
        let trainStatusButton = UIButton()
        trainStatusButton.setBackgroundImage(UIImage.init(named: "icon_link_web"), for: .normal)
        return trainStatusButton
    }()

    ///查看学时记录
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = KUIFont14
        button.setTitle("查看学时记录", for: .normal)
        button.setTitleColor(UIColor.init(red: 105/255.0, green: 171/255.0, blue: 209/255.0, alpha: 1), for: .normal)
        return button
    }()
    
    ///快速推送到公安系统
    lazy var pushButton: UIButton = {
        let pushButton = UIButton()
        pushButton.setBackgroundImage(UIImage.init(named: "icon_select_no"), for: .normal)
        pushButton.setBackgroundImage(UIImage.init(named: "icon_select_yes"), for: .selected)
        return pushButton
    }()
    
    lazy var pushLabel: UILabel = {
        let pushLabel = UILabel()
        pushLabel.font = KUIFont12
        pushLabel.textColor = MainTitleColor
        pushLabel.text = "快速推送到公安考试系统"
        return pushLabel
    }()
    
    ///购买驾考无忧险
    lazy var insuranceButton: UIButton = {
        let insuranceButton = UIButton()
        insuranceButton.setBackgroundImage(UIImage.init(named: "icon_select_no"), for: .normal)
        insuranceButton.setBackgroundImage(UIImage.init(named: "icon_select_yes"), for: .selected)
        return insuranceButton
    }()
    
    lazy var insuranceLabel: UILabel = {
        let insuranceLabel = UILabel()
        insuranceLabel.font = KUIFont12
        insuranceLabel.textColor = MainTitleColor
        insuranceLabel.text = "花10元购买驾考无忧险，考试未通过文案"
        return insuranceLabel
    }()
    
    ///刷新并推送按钮
    lazy var freshAndPushButton: UIButton = {
        let freshBtn = UIButton()
        freshBtn.titleLabel?.font = KUIFont16
        freshBtn.setTitle("刷新并推送", for: .normal)
        freshBtn.setTitleColor(.white, for: .normal)
        freshBtn.backgroundColor = MainTitleColor
        return freshBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI() {
        self.addSubview(progressView)
        self.progressView.snp.makeConstraints { (make) in
            make.width.height.equalTo(160)
            make.centerX.equalToSuperview()
            make.top.equalTo(22)
        }
        
        self.addSubview(tipLabel)
        self.tipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.progressView.snp.bottom).offset(4)
//            make.height.equalTo(40)
        }
        
        self.addSubview(studyProgressLabel)
        self.studyProgressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.progressView.snp.left).offset(-45)
            make.top.equalTo(self.tipLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
        self.addSubview(allStudyLabel)
        self.allStudyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.progressView.snp.left).offset(19)
            make.centerY.equalTo(self.studyProgressLabel.snp.centerY)
            make.width.equalTo(160)
            make.height.equalTo(10)
        }
        
        self.allStudyLabel.addSubview(studyLabel)
        self.studyLabel.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(120)
        }
        
        self.addSubview(percentLabel)
        self.percentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.allStudyLabel.snp.right).offset(4)
            make.centerY.equalTo(self.allStudyLabel.snp.centerY)
        }
        
        self.addSubview(trainTimeLabel)
        self.trainTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.studyProgressLabel.snp.left)
            make.top.equalTo(self.studyProgressLabel.snp.bottom).offset(6)
            make.height.equalTo(20)
        }
        
        self.addSubview(trainLabel)
        self.trainLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.allStudyLabel.snp.left)
            make.centerY.equalTo(self.trainTimeLabel.snp.centerY)
        }
        
        self.addSubview(validTimeLabel)
        self.validTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.studyProgressLabel.snp.left)
            make.top.equalTo(self.trainTimeLabel.snp.bottom).offset(6)
            make.height.equalTo(20)
        }
        
        self.addSubview(validLabel)
        self.validLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.allStudyLabel.snp.left)
            make.centerY.equalTo(self.validTimeLabel.snp.centerY)
        }
        
        self.addSubview(validButton)
        self.validButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.validLabel.snp.right).offset(6)
            make.centerY.equalTo(self.validTimeLabel.snp.centerY)
            make.width.height.equalTo(16)
        }
        
        self.addSubview(trainStatusTitleLabel)
        self.trainStatusTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.studyProgressLabel.snp.left)
            make.top.equalTo(self.validTimeLabel.snp.bottom).offset(6)
            make.height.equalTo(20)
        }
        
        self.addSubview(trainStatusLabel)
        self.trainStatusLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.allStudyLabel.snp.left)
            make.centerY.equalTo(self.trainStatusTitleLabel.snp.centerY)
        }
        
        self.addSubview(trainStatusButton)
        self.trainStatusButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.trainStatusLabel.snp.right).offset(6)
            make.centerY.equalTo(self.trainStatusLabel.snp.centerY)
            make.width.height.equalTo(16)
        }
        
        self.addSubview(checkButton)
        self.checkButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(26)
            make.width.equalTo(100)
            make.top.equalTo(self.trainStatusTitleLabel.snp.bottom).offset(5)
        }
        
        self.addSubview(pushButton)
        self.pushButton.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.checkButton.snp.bottom).offset(21)
            make.width.height.equalTo(12)
        }
        
        self.addSubview(pushLabel)
        self.pushLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.pushButton.snp.right).offset(8)
            make.centerY.equalTo(self.pushButton.snp.centerY)
        }
        
        self.addSubview(insuranceButton)
        self.insuranceButton.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.pushButton.snp.bottom).offset(15)
            make.width.height.equalTo(12)
        }
        
        self.addSubview(insuranceLabel)
        self.insuranceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.insuranceButton.snp.right).offset(8)
            make.centerY.equalTo(self.insuranceButton.snp.centerY)
        }
        
        self.addSubview(freshAndPushButton)
        self.freshAndPushButton.snp.makeConstraints { (make) in
            make.left.height.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.insuranceButton.snp.bottom).offset(32)
        }
    }
    
}
