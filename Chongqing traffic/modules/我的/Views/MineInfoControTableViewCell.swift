//
//  MineInfoControTableViewCell.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/15.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineInfoControTableViewCell: UITableViewCell {
    
    //title
    lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = KUIFont14
        titleLabel.textColor = AssistTextColor
        return titleLabel
    }()
    
    //描述
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.font = KUIFont14
        descLabel.textColor = AssistColor
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    lazy var userLogoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.cornerRadius = 20
        logoImageView.contentMode = UIView.ContentMode.scaleAspectFill
        return logoImageView
    }()
    
    //右边小箭头
    private var rightImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "icon_right_tip2")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI() {
        
        self.contentView.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(40)
        }
        
        self.contentView.addSubview(rightImageView)
        self.rightImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-40)
        }
        
        self.contentView.addSubview(userLogoImageView)
        self.userLogoImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.rightImageView.snp.left).offset(-10)
            make.width.height.equalTo(40)
        }
        
        self.contentView.addSubview(descLabel)
        self.descLabel.snp.makeConstraints { (make) in
            make.left.greaterThanOrEqualTo(self.titleLabel.snp.right).offset(20)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(self.rightImageView.snp.left).offset(-10)
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
