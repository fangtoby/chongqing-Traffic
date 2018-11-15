//
//  MineInfoTableViewCell.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/14.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineInfoTableViewCell: UITableViewCell {
    //背景视图
    lazy var bgView:UIView = {
       let bgview = UIView()
        bgview.backgroundColor = .white
        bgview.layer.cornerRadius = 10
        //添加阴影
        bgview.layer.shadowColor = UIColor.black.cgColor
        bgview.layer.shadowOpacity = 0.05
        //zero表示不偏移
        bgview.layer.shadowOffset = CGSize.zero
        bgview.layer.shadowRadius = 5
        
        return bgview
    }()
    
    //用户图像
    lazy var userLogoImageView:UIImageView = {
       let iconImageView = UIImageView()
        iconImageView.image = UIImage.init(named: "pic1.jpeg")
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 30
        return iconImageView
    }()
    
    //用户姓名
    lazy var nameLabel:UILabel = {
       let nameLabel = UILabel()
        nameLabel.font = KUIFont20
        nameLabel.textColor = MainYellowColor
        nameLabel.text = "哈哈哈"
        return nameLabel
    }()
    
    //描述
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.font = KUIFont12
        descLabel.textColor = AssistColor
        descLabel.numberOfLines = 0
        descLabel.text = "目前正在呱呱驾校学习C1技能"
        return descLabel
    }()
    
    //右边小箭头
    private var rightImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage.init(named: "icon_right_tip")
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI() {
        self.contentView.addSubview(bgView)
        self.bgView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(95)
        }
        bgView.addSubview(userLogoImageView)
        self.userLogoImageView.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 60, height: 60))
        }
        
        bgView.addSubview(nameLabel)
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(self.userLogoImageView.snp.right).offset(20)
            make.height.equalTo(28)
            make.right.lessThanOrEqualTo(-50)
        }
        
        bgView.addSubview(descLabel)
        self.descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.nameLabel.snp.left)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(10)
            make.right.equalTo(-50)
        }
        
        bgView.addSubview(rightImageView)
        self.rightImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-30)
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
