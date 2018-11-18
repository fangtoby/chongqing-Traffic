//
//  PeriodRecordDetailInfoView.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/17.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

// 创建闭包
typealias ComplaintBtnClick = () -> (Void)

class PeriodRecordDetailInfoView: UIView {
    
    var complaintBtnClick : ComplaintBtnClick?

    //编号
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "编号：0001"
        label.font = KUIFont16
        label.textColor = .black
        return label
    }()
    
    //一键投诉
    lazy var complaintButton: BaseButton = {
        let button = BaseButton()
        button.backgroundColor = MainYellowColor
        button.titleLabel?.font = KUIFont12
        button.setTitle("一键投诉", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(complaint), for: .touchUpInside)
        return button
    }()
    
    //开始时间
    lazy var beginTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "培训开始时间"
        return tipLabel
    }()
    
    lazy var beginLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.text = "2018-10-30 08:42:33"
        return label
    }()
    
    //结束时间
    lazy var endTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "培训结束时间"
        return tipLabel
    }()
    
    lazy var endLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.text = "2018-10-30 09:31:29"
        return label
    }()
    
    //培训学时
    lazy var trainTimeTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "本次培训学时"
        return tipLabel
    }()
    
    lazy var trainTimeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.text = "1学时4分钟"
        return label
    }()
    
    //培训学时
    lazy var trainDistanceTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "本次培训里程"
        return tipLabel
    }()
    
    lazy var trainDistanceLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.text = "10公里"
        return label
    }()
    
    //培训学时不合格原因
    lazy var trainFailResonTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "培训学时不合格原因"
        return tipLabel
    }()
    
    lazy var trainFailResonLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "10：找不到对应的分钟学时\n11：找不到对应的学时"
        return label
    }()
    
    lazy var trainFailResonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "icon_link_web")
        return imageView
    }()
    
    
    //培训学时不合格原因
    lazy var trainSchoolTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "培训机构"
        return tipLabel
    }()
    
    lazy var trainSchoolLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.text = "重庆市机动车驾驶培训有限公司"
        return label
    }()
    
    //教练员
    lazy var coachTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "教练员"
        return tipLabel
    }()
    
    lazy var coachLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.text = "张书军"
        return label
    }()
    
    //教练车牌号
    lazy var carCodeTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "教练车牌号"
        return tipLabel
    }()
    
    lazy var carCodeLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.text = "冀E3733学"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func complaint() {
        guard let complaintBtnClick = complaintBtnClick else { return }
        complaintBtnClick()
    }
}

extension PeriodRecordDetailInfoView {
    func setUpUI() {
        self.addSubview(numberLabel)
        self.numberLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(22)
            make.height.equalTo(22)
        }
        
        self.addSubview(complaintButton)
        self.complaintButton.snp.makeConstraints { (make) in
            make.right.equalTo(-40)
            make.centerY.equalTo(self.numberLabel.snp.centerY)
            make.height.equalTo(24)
            make.width.equalTo(60)
        }
        
        self.addSubview(beginTipLabel)
        self.beginTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.numberLabel.snp.bottom).offset(20)
        }
        
        self.addSubview(beginLabel)
        self.beginLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.beginTipLabel.snp.right).offset(8)
            make.centerY.equalTo(self.beginTipLabel.snp.centerY)
        }
        
        self.addSubview(endTipLabel)
        self.endTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.beginTipLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(endLabel)
        self.endLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.beginLabel.snp.left)
            make.centerY.equalTo(self.endTipLabel.snp.centerY)
        }
        
        self.addSubview(trainTimeTipLabel)
        self.trainTimeTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.endTipLabel.snp.bottom).offset(20)
        }
        
        self.addSubview(trainTimeLabel)
        self.trainTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.beginLabel.snp.left)
            make.centerY.equalTo(self.trainTimeTipLabel.snp.centerY)
        }
        
        self.addSubview(trainDistanceTipLabel)
        self.trainDistanceTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.trainTimeTipLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(trainDistanceLabel)
        self.trainDistanceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.beginLabel.snp.left)
            make.centerY.equalTo(self.trainDistanceTipLabel.snp.centerY)
        }
        
        self.addSubview(trainFailResonTipLabel)
        self.trainFailResonTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.trainDistanceTipLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(trainFailResonLabel)
        self.trainFailResonLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.trainFailResonTipLabel.snp.right).offset(8)
            make.top.equalTo(self.trainFailResonTipLabel.snp.top)
            make.right.lessThanOrEqualToSuperview().offset(-20)
            make.height.greaterThanOrEqualTo(20)
        }
        
        self.addSubview(trainSchoolTipLabel)
        self.trainSchoolTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.trainFailResonLabel.snp.bottom).offset(20)
        }
        
        self.addSubview(trainSchoolLabel)
        self.trainSchoolLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.beginLabel.snp.left)
            make.centerY.equalTo(self.trainSchoolTipLabel.snp.centerY)
        }
        
        self.addSubview(coachTipLabel)
        self.coachTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.trainSchoolTipLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(coachLabel)
        self.coachLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.beginLabel.snp.left)
            make.centerY.equalTo(self.coachTipLabel.snp.centerY)
        }
        
        self.addSubview(carCodeTipLabel)
        self.carCodeTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.coachTipLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(carCodeLabel)
        self.carCodeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.beginLabel.snp.left)
            make.centerY.equalTo(self.carCodeTipLabel.snp.centerY)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
