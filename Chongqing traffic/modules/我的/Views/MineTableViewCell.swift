//
//  MineTableViewCell.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/5.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineTableViewCell: UITableViewCell {
    
    //icon
    private var iconImageView:UIImageView = {
        let iconImageView = UIImageView()
        
        return iconImageView
    }()
    
    //title
    private var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = KUIFont14
        titleLabel.textColor = MainTitleColor
        titleLabel.text = "哈哈哈"
        return titleLabel
    }()
    
    //描述
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.font = KUIFont14
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
    
    //分割线
    lazy var topLineView : UIView = {
       let lineView = UIView()
        lineView.backgroundColor = KUIColorLine
        return lineView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI() {
        
        self.contentView.addSubview(iconImageView)
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(self.iconImageView.snp.right).offset(8)
        }
        
        self.contentView.addSubview(rightImageView)
        self.rightImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-40)
        }
        
        self.contentView.addSubview(descLabel)
        self.descLabel.snp.makeConstraints { (make) in
            make.left.greaterThanOrEqualTo(self.titleLabel.snp.right).offset(10)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(self.rightImageView.snp.left).offset(-20)
        }
        
        self.contentView.addSubview(topLineView)
        self.topLineView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setDicInfo(dicInfo:NSDictionary?) {
        self.iconImageView.image = UIImage.init(named: dicInfo?["icon"] as! String)
        self.titleLabel.text = dicInfo?["title"] as? String
        self.descLabel.text = dicInfo?["desc"] as? String
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
