//
//  PeriodRecordTableViewCell.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/16.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class PeriodRecordTableViewCell: UITableViewCell {
    //topLine
    lazy var topLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = KUIColorLine
        return lineView
    }()
    
    //培训日期
    private lazy var dateImageView: UIImageView = {
        let dateImageView = UIImageView()
        dateImageView.image = UIImage.init(named: "icon_train_date")
        return dateImageView
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = KUIFont14
        dateLabel.textColor = .black
//        dateLabel.text = "2018-08-17"
        return dateLabel
    }()
    
    //培训时间段
    private lazy var timeImageView: UIImageView = {
        let timeImageView = UIImageView()
        timeImageView.image = UIImage.init(named: "icon_train_time")
        return timeImageView
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = KUIFont14
        timeLabel.textColor = .black
//        timeLabel.text = "08:42:23～09:31:56"
        return timeLabel
    }()
    
    //培训信息
    //时长
    private lazy var trainTimeTipLabel: UILabel = {
        let label = UILabel ()
        label.font = KUIFont12
        label.textColor = Main155Color
        label.text = "培训时长"
        return label
    }()
    lazy var trainTimeLabel: UILabel = {
        let label = UILabel ()
        label.font = KUIFont12
        label.textColor = .black
//        label.text = "1学时04分"
        return label
    }()
    
    //有效学时
    private lazy var validTipLabel: UILabel = {
        let label = UILabel ()
        label.font = KUIFont12
        label.textColor = Main155Color
        label.text = "有效学时"
        return label
    }()
    lazy var validLabel: UILabel = {
        let label = UILabel ()
        label.font = KUIFont12
        label.textColor = .black
//        label.text = "1学时04分"
        return label
    }()
    
    //学时类型
    private lazy var typeTipLabel: UILabel = {
        let label = UILabel ()
        label.font = KUIFont12
        label.textColor = Main155Color
        label.text = "学时类型"
        return label
    }()
    lazy var typeLabel: UILabel = {
        let label = UILabel ()
        label.font = KUIFont12
        label.textColor = .black
//        label.text = "实操"
        return label
    }()
    
    //教练车牌号
    private lazy var numberTipLabel: UILabel = {
        let label = UILabel ()
        label.font = KUIFont12
        label.textColor = Main155Color
        label.text = "教练车牌号"
        return label
    }()
    lazy var numberLabel: UILabel = {
        let label = UILabel ()
        label.font = KUIFont12
        label.textColor = .black
//        label.text = "冀E3733学"
        return label
    }()
    
    //教练员
    private lazy var coachTipLabel: UILabel = {
        let label = UILabel ()
        label.font = KUIFont12
        label.textColor = Main155Color
        label.text = "教练员"
        return label
    }()
    lazy var coachLabel: UILabel = {
        let label = UILabel ()
        label.font = KUIFont12
        label.textColor = .black
//        label.text = "张书军"
        return label
    }()
    
    //培训学时不合格原因
    private lazy var trainFailTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont12
        tipLabel.textColor = Main155Color
        tipLabel.text = "培训学时不合格原因"
        return tipLabel
    }()
    lazy var trainFailLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont12
        label.textColor = .black
        label.numberOfLines = 0
//        label.text = "10：找不到对应的分钟学时\n11：找不到对应的学时"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    func setUpUI() {
        self.contentView.addSubview(topLineView)
        self.topLineView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        self.contentView.addSubview(dateImageView)
        self.dateImageView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(23)
            make.width.height.equalTo(14)
        }
        
        self.contentView.addSubview(dateLabel)
        self.dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.dateImageView.snp.right).offset(8)
            make.centerY.equalTo(self.dateImageView.snp.centerY)
        }
        
        self.contentView.addSubview(timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.dateLabel.snp.centerY)
            make.right.equalTo(-20)
        }
        
        self.contentView.addSubview(timeImageView)
        self.timeImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.dateLabel.snp.centerY)
            make.right.equalTo(self.timeLabel.snp.left).offset(-8)
            make.width.height.equalTo(14)
        }
        
        self.contentView.addSubview(trainTimeTipLabel)
        self.trainTimeTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.dateLabel.snp.left)
            make.top.equalTo(self.dateLabel.snp.bottom).offset(20)
        }
        
        self.contentView.addSubview(trainTimeLabel)
        self.trainTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.trainTimeTipLabel.snp.centerY)
            make.left.equalTo(self.trainTimeTipLabel.snp.right).offset(8)
        }
        
        self.contentView.addSubview(validTipLabel)
        self.validTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.dateLabel.snp.left)
            make.top.equalTo(self.trainTimeTipLabel.snp.bottom).offset(10)
        }
        
        self.contentView.addSubview(validLabel)
        self.validLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.validTipLabel.snp.centerY)
            make.left.equalTo(self.validTipLabel.snp.right).offset(8)
        }
        
        self.contentView.addSubview(typeTipLabel)
        self.typeTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.dateLabel.snp.left)
            make.top.equalTo(self.validTipLabel.snp.bottom).offset(10)
        }
        
        self.contentView.addSubview(typeLabel)
        self.typeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.typeTipLabel.snp.centerY)
            make.left.equalTo(self.typeTipLabel.snp.right).offset(8)
        }
        
        self.contentView.addSubview(numberTipLabel)
        self.numberTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeLabel.snp.left)
            make.top.equalTo(self.trainTimeTipLabel.snp.top)
        }
        
        self.contentView.addSubview(numberLabel)
        self.numberLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.numberTipLabel.snp.centerY)
            make.left.equalTo(self.numberTipLabel.snp.right).offset(8)
        }
        
        self.contentView.addSubview(coachTipLabel)
        self.coachTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeLabel.snp.left)
            make.top.equalTo(self.validLabel.snp.top)
        }
        
        self.contentView.addSubview(coachLabel)
        self.coachLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.coachTipLabel.snp.centerY)
            make.left.equalTo(self.numberLabel.snp.left)
        }
        
        self.contentView.addSubview(trainFailTipLabel)
        self.trainFailTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.trainTimeTipLabel.snp.left)
            make.top.equalTo(self.typeTipLabel.snp.bottom).offset(10)
        }
        
        self.contentView.addSubview(trainFailLabel)
        self.trainFailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.trainFailTipLabel.snp.right).offset(8)
            make.top.equalTo(self.trainFailTipLabel.snp.top)
            make.right.equalTo(-20)
            make.bottom.equalTo(-20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension PeriodRecordTableViewCell {
    func setDicInfo(dicInfo:NSDictionary?) {
        dateLabel.text = dicInfo?.object(forKey: "trainingdate") as? String
        
        let starTime = dicInfo?.object(forKey: "starttime") as? Double
        let endTime = dicInfo?.object(forKey: "endtime") as? Double
        let starDate = Date.getNowDateFromatAnDate(Date(timeIntervalSince1970: (starTime ?? 0)/1000))
        let endDate = Date.getNowDateFromatAnDate(Date(timeIntervalSince1970: (endTime ?? 0)/1000))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let starDateStr = formatter.string(from: starDate)
        let endDateStr = formatter.string(from: endDate)
        timeLabel.text = "\(starDateStr)~\(endDateStr)"
        
        var trainTime = dicInfo?.object(forKey: "duration") as? Int
        if trainTime == nil {
            trainTime = 0
        }
        trainTimeLabel.text = "\(trainTime!/45)学时\(trainTime!%45)分"
        
        var validTime = dicInfo?.object(forKey: "lastinstancetime") as? Int
        if validTime == nil {
            validTime = 0
        }
        validLabel.text = "\(validTime!/45)学时\(validTime!%45)分"
        
        let type = dicInfo?.object(forKey: "subjcode") as? String
        if type == "1" {
            typeLabel.text = "实操"
        }else if type == "2" {
            typeLabel.text = "课堂教学"
        }else if type == "3" {
            typeLabel.text = "模拟器教学"
        }else if type == "4" {
            typeLabel.text = "远程教学"
        }
        
        numberLabel.text = dicInfo?.object(forKey: "carName") as? String
        coachLabel.text = dicInfo?.object(forKey: "coachName") as? String
        
        let failReason = dicInfo?.object(forKey: "recheckreason") as? String
        if failReason == nil || failReason == "" {
            trainFailTipLabel.isHidden = true
            trainFailLabel.isHidden = true
            self.typeLabel.snp.remakeConstraints { (make) in
                make.centerY.equalTo(self.typeTipLabel.snp.centerY)
                make.left.equalTo(self.typeTipLabel.snp.right).offset(8)
                make.bottom.equalTo(-20)
            }
            self.trainFailLabel.snp.remakeConstraints { (make) in
                make.left.equalTo(self.trainFailTipLabel.snp.right).offset(8)
                make.top.equalTo(self.trainFailTipLabel.snp.top)
                make.right.equalTo(-20)
            }
        }else {
            var faildStr : String = ""
            var faildArray =  failReason?.components(separatedBy: ",")
            faildArray?.removeLast()
            if faildArray != nil {
                for index in 0..<faildArray!.count {
                    let str = faildArray?[index]
                    let reason = faildReason(index: str!)
                    
                    if index == 0 {
                        faildStr = faildStr + reason
                    }else {
                        faildStr = faildStr + "\n" + reason
                    }
                }
            }
            
            trainFailLabel.text = faildStr
            
            trainFailTipLabel.isHidden = false
            trainFailLabel.isHidden = false
            self.typeLabel.snp.remakeConstraints { (make) in
                make.centerY.equalTo(self.typeTipLabel.snp.centerY)
                make.left.equalTo(self.typeTipLabel.snp.right).offset(8)
            }
            self.trainFailLabel.snp.remakeConstraints { (make) in
                make.left.equalTo(self.trainFailTipLabel.snp.right).offset(8)
                make.top.equalTo(self.trainFailTipLabel.snp.top)
                make.right.equalTo(-20)
                make.bottom.equalTo(-20)
            }
        }
        
    }
}
