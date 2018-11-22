//
//  InsuranceOrderInfoView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/21.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

// 创建闭包
typealias CloseBtnClick = () -> (Void)

class InsuranceOrderInfoView: UIView {

    var closeBtnClick : CloseBtnClick?
    
    lazy var closeBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "btn_close"), for: .normal)
        button.addTarget(self, action: #selector(closeBtnClicked), for: .touchUpInside)
        return button
    }()
    
    //保险图片
    lazy var ensureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = KUIColorBG
        return imageView
    }()
    
    //保险名称
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = KBUIFont16
        label.textColor = MainTitleColor
        label.text = "科目一无忧险"
        return label
    }()
    
    //有效期
    lazy var validDateTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "有效期限"
        return tipLabel
    }()
    lazy var validDateLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.text = "365天"
        return label
    }()
    
    //价格
    lazy var moneyTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "价格"
        return tipLabel
    }()
    lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = MainYellowColor
        label.text = "￥30"
        return label
    }()
    
    //说明
    lazy var explainTipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = KUIFont14
        tipLabel.textColor = Main155Color
        tipLabel.text = "说明"
        return tipLabel
    }()
    lazy var explainLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont12
        label.textColor = .black
        label.text = "保险生效后如本考试科目不通过则赔付￥200"
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func closeBtnClicked () {
        guard let closeBtnClick = closeBtnClick else { return }
        closeBtnClick()
    }
}

extension InsuranceOrderInfoView {
    func setUpUI() {
        self.addSubview(closeBtn)
        self.closeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.right.equalTo(-20)
            make.width.height.equalTo(14)
        }
        
        ///保险图片
        self.addSubview(ensureImageView)
        self.ensureImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(40)
            if KScreenWidth >= 375 {
                make.width.equalTo(160)
                make.height.equalTo(90)
            }else {
                make.width.equalTo(100)
                make.height.equalTo(100*9/16)
            }
        }
        
        ///保险名称
        self.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.ensureImageView.snp.top)
            make.left.equalTo(self.ensureImageView.snp.right).offset(20)
            make.right.lessThanOrEqualTo(-15)
        }
        
        ///有效期
        self.addSubview(validDateTipLabel)
        self.validDateTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel.snp.left)
            make.top.equalTo(self.ensureImageView.snp.centerY).offset(-2)
        }
        self.addSubview(validDateLabel)
        self.validDateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.validDateTipLabel.snp.centerY)
            make.left.equalTo(self.validDateTipLabel.snp.right).offset(8)
        }
        
        ///价格
        self.addSubview(moneyTipLabel)
        self.moneyTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.validDateTipLabel.snp.left)
            make.bottom.equalTo(self.ensureImageView.snp.bottom)
        }
        self.addSubview(moneyLabel)
        self.moneyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.validDateLabel.snp.left)
            make.centerY.equalTo(self.moneyTipLabel.snp.centerY)
        }
        
        ///说明
        self.addSubview(explainTipLabel)
        self.explainTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.ensureImageView.snp.bottom).offset(10)
        }
        self.addSubview(explainLabel)
        self.explainLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.explainTipLabel.snp.right).offset(8)
            make.top.equalTo(self.explainTipLabel.snp.top).offset(1)
            make.bottom.equalTo(-10)
        }
    }
}
