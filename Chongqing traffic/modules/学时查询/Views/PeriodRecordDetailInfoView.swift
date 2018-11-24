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
//        label.text = "编号：0001"
        label.font = KUIFont16
        label.textColor = .black
        return label
    }()
    
    //一键投诉
    lazy var complaintButton: BaseButton = {
        let button = BaseButton()
        button.backgroundColor = UIColor(r: 255, g: 229, b: 147)
        button.titleLabel?.font = KUIFont12
        button.setTitle("一键投诉", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
        button.isUserInteractionEnabled = false
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
//        label.text = "2018-10-30 08:42:33"
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
//        label.text = "2018-10-30 09:31:29"
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
//        label.text = "1学时4分钟"
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
//        label.text = "10公里"
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
//        label.text = "10：找不到对应的分钟学时\n11：找不到对应的学时"
        return label
    }()
    
    lazy var trainFailResonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "icon_link_web")
        return imageView
    }()
    
    //培训机构
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
        label.numberOfLines = 0
//        label.text = "重庆市机动车驾驶培训有限公司"
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
//        label.text = "张书军"
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
//        label.text = "冀E3733学"
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
    
    func isComplaint(complaint:Bool) {
        if complaint == true  {
            complaintButton.setTitle("已投诉", for: .normal)
            complaintButton.backgroundColor = UIColor(r: 255, g: 229, b: 147)
            complaintButton.isUserInteractionEnabled = false
        }else {
            complaintButton.setTitle("一键投诉", for: .normal)
            complaintButton.backgroundColor = MainYellowColor
            complaintButton.isUserInteractionEnabled = true
        }
    }
    
    func setUpData(dicInfo:NSDictionary?) {
        numberLabel.text = "编号：\(dicInfo?.object(forKey: "rated") ?? "")"
        
        let starTime = dicInfo?.object(forKey: "starttime") as? Double
        let endTime = dicInfo?.object(forKey: "endtime") as? Double
        let starDate = Date.getNowDateFromatAnDate(Date(timeIntervalSince1970: (starTime ?? 0)/1000))
        let endDate = Date.getNowDateFromatAnDate(Date(timeIntervalSince1970: (endTime ?? 0)/1000))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let starDateStr = formatter.string(from: starDate)
        let endDateStr = formatter.string(from: endDate)
        
        beginLabel.text = starDateStr
        endLabel.text = endDateStr
        
        var study = dicInfo?.object(forKey: "duration") as? Int
        if study == nil {
            study = 0
        }
        trainTimeLabel.text = "\(study!/45)学时\(study!%45)分"
        trainDistanceLabel.text = "\(dicInfo?.object(forKey: "mileage") ?? 0)公里"
        
        let failReason = dicInfo?.object(forKey: "recheckreason") as? String
        if failReason == nil || failReason == "" {
            trainFailResonLabel.isHidden = true
            trainFailResonTipLabel.isHidden = true
            self.trainSchoolTipLabel.snp.remakeConstraints { (make) in
                make.left.equalTo(40)
                make.top.equalTo(self.trainDistanceTipLabel.snp.bottom).offset(20)
            }
            
        }else {
            var faildStr : String = ""
            var faildArray =  failReason?.components(separatedBy: ",")
            faildArray?.removeLast()
            if faildArray != nil {
                for index in 0..<faildArray!.count {
                    let str = faildArray?[index]
                    let reason = faildReason(index: str!)
                    //                    faildStr = faildStr + reason
                    if index == 0 {
                        faildStr = faildStr + reason
                    }else {
                        faildStr = faildStr + "\n" + reason
                    }
                }
            }
            trainFailResonLabel.isHidden = false
            trainFailResonTipLabel.isHidden = false
            trainFailResonLabel.text = faildStr
            
            self.trainSchoolTipLabel.snp.remakeConstraints { (make) in
                make.left.equalTo(40)
                make.top.equalTo(self.trainFailResonLabel.snp.bottom).offset(20)
            }
        }
        
        trainSchoolLabel.text = dicInfo?.object(forKey: "schName") as? String
        coachLabel.text = dicInfo?.object(forKey: "coachName") as? String
        carCodeLabel.text = dicInfo?.object(forKey: "carName") as? String
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
        trainSchoolTipLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: NSLayoutConstraint.Axis.horizontal)
        self.trainSchoolTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.trainFailResonLabel.snp.bottom).offset(20)
        }
        
        self.addSubview(trainSchoolLabel)
        self.trainSchoolLabel.snp.makeConstraints { (make) in
            make.left.equalTo(135)
            make.top.equalTo(self.trainSchoolTipLabel.snp.top)
            make.right.lessThanOrEqualTo(-20)
            make.height.greaterThanOrEqualTo(20)
        }
        
        self.addSubview(coachTipLabel)
        self.coachTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.trainSchoolLabel.snp.bottom).offset(10)
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
