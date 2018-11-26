//
//  PeriodRecordDetailImagesView.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/17.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class PeriodRecordDetailImagesView: UIView {
    
    private lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.text = "培训过程图片"
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        return tipLabel
    }()
    
    //签到
    lazy var beginImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = KUIColorBG
        imageView.image = UIImage.init(named: "bg_default_img")
        return imageView
    }()
    
    lazy var beginLabel: UILabel = {
        let label = UILabel()
        label.text = "签到"
        label.font = KUIFont12
        label.textColor = Main155Color
        return label
    }()
    
    //培训中
    lazy var trainingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = KUIColorBG
        imageView.image = UIImage.init(named: "bg_default_img")
        return imageView
    }()
    
    lazy var trainingLabel: UILabel = {
        let label = UILabel()
        label.text = "培训中"
        label.font = KUIFont12
        label.textColor = Main155Color
        return label
    }()
    
    //签退
    lazy var endImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = KUIColorBG
        imageView.image = UIImage.init(named: "bg_default_img")
        return imageView
    }()
    
    lazy var endLabel: UILabel = {
        let label = UILabel()
        label.text = "签退"
        label.font = KUIFont12
        label.textColor = Main155Color
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

extension PeriodRecordDetailImagesView {
    func setUpUI() {
        
        let distanceMargin = 4
        let width = (KScreenWidth - 80 - 8)/3.0
        
        self.addSubview(tipLabel)
        self.tipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(10)
        }
        
        self.addSubview(beginImageView)
        self.beginImageView.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.tipLabel.snp.bottom).offset(10)
            make.width.equalTo(width)
            make.height.equalTo(width*9/12)
        }
        
        self.addSubview(endImageView)
        self.endImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-40)
            make.top.equalTo(self.beginImageView.snp.top)
            make.width.equalTo(width)
            make.height.equalTo(width*9/12)
        }
        
        self.addSubview(trainingImageView)
        self.trainingImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.beginImageView.snp.right).offset(distanceMargin)
            make.right.equalTo(self.endImageView.snp.left).offset(-4)
            make.top.equalTo(self.beginImageView.snp.top)
            make.height.equalTo(width*9/12)
        }
        
        self.addSubview(beginLabel)
        self.beginLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.beginImageView.snp.centerX)
            make.top.equalTo(self.beginImageView.snp.bottom).offset(10)
        }
        
        self.addSubview(trainingLabel)
        self.trainingLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.trainingImageView.snp.centerX)
            make.top.equalTo(self.beginLabel.snp.top)
        }
        
        self.addSubview(endLabel)
        self.endLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.endImageView.snp.centerX)
            make.top.equalTo(self.beginLabel.snp.top)
        }
    }
}
