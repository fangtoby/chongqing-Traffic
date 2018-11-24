//
//  PeriodSearchView.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/15.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

import Charts

// 创建闭包
typealias PeriodAllBtnClick = ((Int) -> (Void))

class PeriodSearchView: UIView {
    
    var periodAllBtnClick : PeriodAllBtnClick?

    lazy var chartView: PieChartView = {
        let chartView = PieChartView()
        chartView.rotationEnabled = false
        chartView.drawEntryLabelsEnabled = false
        
//        chartView.centerAttributedText = attributeStr
//        chartView.centerText = "19.4%\n本月合格率"
        chartView.holeRadiusPercent = 0.6
        chartView.holeColor = .white
        chartView.transparentCircleRadiusPercent = 0
        chartView.setExtraOffsets(left: 0, top: 0, right: 0, bottom: 0)
        chartView.legend.enabled = false
        return chartView
    }()
    
    lazy var unPassPercentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.numberOfLines = 0
        tipLabel.font = KUIFont14
        tipLabel.textColor = AssistColor
        tipLabel.textAlignment = .center
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
        studyLabel.backgroundColor = MainBlueColor
        return studyLabel
    }()
    
    lazy var percentLabel: UILabel = {
        let percentLabel = UILabel()
        percentLabel.font = KUIFont10
        percentLabel.textColor = MainBlueColor
        percentLabel.text = "0%"
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
//        label.text = "12小时20分钟"
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
//        label.text = "12学时"
        return label
    }()
    
    lazy var validButton: UIButton = {
        let validBtn = UIButton()
        validBtn.tag = 11
        validBtn.setBackgroundImage(UIImage.init(named: "icon_link_web"), for: .normal)
        validBtn.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
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
//        label.text = "未推送考试系统"
        return label
    }()
    
    lazy var trainStatusButton: UIButton = {
        let trainStatusButton = UIButton()
        trainStatusButton.setBackgroundImage(UIImage.init(named: "icon_link_web"), for: .normal)
        trainStatusButton.tag = 12
        trainStatusButton.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
        return trainStatusButton
    }()

    ///查看学时记录
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = KUIFont14
        button.setTitle("查看学时记录", for: .normal)
        button.setTitleColor(MainBlueColor, for: .normal)
        button.tag = 13
        button.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
        return button
    }()
    
    ///快速推送到公安系统
    lazy var pushButton: UIButton = {
        let pushButton = UIButton()
        pushButton.tag = 101
        pushButton.setBackgroundImage(UIImage.init(named: "icon_select_no"), for: .normal)
        pushButton.setBackgroundImage(UIImage.init(named: "icon_select_yes"), for: .selected)
        pushButton.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
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
        insuranceButton.tag = 102
        insuranceButton.isSelected = true
        insuranceButton.setBackgroundImage(UIImage.init(named: "icon_select_no"), for: .normal)
        insuranceButton.setBackgroundImage(UIImage.init(named: "icon_select_yes"), for: .selected)
        insuranceButton.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
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
        freshBtn.tag = 14
        freshBtn.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
        return freshBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        setDateEmpty()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpUI() {
        
        self.addSubview(chartView)
        self.chartView.snp.makeConstraints { (make) in
            make.width.height.equalTo(160)
            make.centerX.equalToSuperview()
            make.top.equalTo(22)
        }
        
        self.addSubview(unPassPercentLabel)
        self.unPassPercentLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.chartView.snp.center)
        }
        
        self.addSubview(tipLabel)
        self.tipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.chartView.snp.bottom).offset(4)
//            make.height.equalTo(40)
        }
        
        self.addSubview(studyProgressLabel)
        self.studyProgressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.chartView.snp.left).offset(-45)
            make.top.equalTo(self.tipLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
        self.addSubview(allStudyLabel)
        self.allStudyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.chartView.snp.left).offset(19)
            make.centerY.equalTo(self.studyProgressLabel.snp.centerY)
            make.width.equalTo(160)
            make.height.equalTo(10)
        }
        
        self.addSubview(studyLabel)
        self.studyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.chartView.snp.left).offset(19)
            make.centerY.equalTo(self.studyProgressLabel.snp.centerY)
            make.width.equalTo(0)
            make.height.equalTo(10)
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
            make.width.height.equalTo(14)
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
            make.width.height.equalTo(14)
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
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }
    
    @objc func buttonClicked(button: UIButton) {
        if button.tag == 101 || button.tag == 102 {
            if button.isSelected == true {
                button.isSelected = false
            }else {
                button.isSelected = true
            }
        }else {
            guard let periodAllBtnClick = periodAllBtnClick else { return }
            periodAllBtnClick(button.tag)
        }
    }
}

extension PeriodSearchView {
    func setDateEmpty() {
        let value1:Double = 0
        let value2:Double = 100
        var yValues:[BarChartDataEntry] = []
        let entryValue1 = BarChartDataEntry.init(x: 1, yValues: [value1] )
        let entryValue2 = BarChartDataEntry.init(x: 2, yValues: [value2] )
        yValues.append(entryValue1)
        yValues.append(entryValue2)
        let dataSet = PieChartDataSet.init(values: yValues, label: "")
        dataSet.drawValuesEnabled = false
        dataSet.selectionShift = 0
        dataSet.valueLineVariableLength = false
        dataSet.sliceSpace = 5
        var colors: [UIColor] = []
        colors.append(MainYellowColor)
        colors.append(KUIColorLine)
        dataSet.colors = colors
        let data = PieChartData.init(dataSets: [dataSet])
        chartView.data = data
    }
    
    // 动画效果
    func doAnimate() -> Void {
        chartView.animate(xAxisDuration: 1, easingOption: ChartEasingOption.easeOutSine)
    }
    
    func setChartData(dicInfo:NSDictionary?) {
//        doAnimate()
        //此处填入展示的相应数字
        let value1 = dicInfo?.valueAsDouble(forKey: "passing")
        var value2:Double = 100
        if value1 != nil {
            value2 = 100 - value1!
        }
        
        
        var yValues:[ChartDataEntry] = []
        let entryValue1 = BarChartDataEntry.init(x: 1, yValues: [value1 ?? 0])
        let entryValue2 = BarChartDataEntry.init(x: 2, yValues: [value2] )
        
        yValues.append(entryValue1)
        yValues.append(entryValue2)
        
        let dataSet = PieChartDataSet.init(values: yValues, label: "")
        dataSet.drawValuesEnabled = false
        dataSet.selectionShift = 0
        dataSet.valueLineVariableLength = false
        dataSet.sliceSpace = 5
        
        var colors: [UIColor] = []
        colors.append(MainYellowColor)
        colors.append(KUIColorLine)
        
        dataSet.colors = colors
        let data = PieChartData.init(dataSets: [dataSet])
        
        chartView.data = data
        
        let str = "\(value1 ?? 0)%"
        let str1 = "\n本月合格率"
        let attributeStr = NSMutableAttributedString.init(string: str.appending(str1))
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 26),
            NSAttributedString.Key.foregroundColor: MainYellowColor]
        
        let mulAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: AssistColor]
        attributeStr.addAttributes(multipleAttributes, range: NSRange.init(location: 0, length: str.count))
        attributeStr.addAttributes(mulAttributes, range: NSRange.init(location: str.count, length: str1.count))
        unPassPercentLabel.attributedText = attributeStr
        
        let unPassStr = NSMutableAttributedString.init(string: "本月有\(value2)%的学员\n无法一次性通过本科目考试")
        let mutipleAttr : [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: MainRedColor]
        unPassStr.addAttributes(mutipleAttr, range: NSRange.init(location: 2, length: String(value2).count+1))
        tipLabel.attributedText = unPassStr
        
        var allStudy = dicInfo?.object(forKey: "requireTime") as? Int
        var study = dicInfo?.object(forKey: "trainTime") as? Int
        var valid = dicInfo?.object(forKey: "validTime") as? Int
        if allStudy == nil {
            allStudy = 1
        }
        if study == nil {
            study = 0
        }
        if valid == nil {
            valid = 0
        }
        var percent = Double(valid!)/Double(allStudy!)*100
        if percent > 100 {
            percent = 100
        }
        let percentStr = String(format: "%.2f", percent)
        
        self.studyLabel.snp.updateConstraints { (make) in
            make.width.equalTo(160*percent/100)
        }
        percentLabel.text = "\(percentStr)%"
        trainLabel.text = "\(study!/60)小时\(study!%60)分钟"
        validLabel.text = "\(valid!/45)学时\(valid!%45)分"
        
        let trainStatus = dicInfo?.object(forKey: "trainType") as? String
        if trainStatus == "1" {
            trainStatusLabel.text = "未满足推送考试系统要求"
        }else if trainStatus == "2" {
            trainStatusLabel.text = "待推送考试系统"
        }else if trainStatus == "3" {
            trainStatusLabel.text = "已推送考试系统"
        }else {
            trainStatusLabel.text = "未满足推送考试系统要求"
        }
    }
}
