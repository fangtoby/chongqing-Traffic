//
//  TrainingStatusTableViewCell.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/21.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class TrainingStatusTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = Main155Color
        label.text = "1.未推送考试系统"
        return label
    }()
    
    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = .black
        label.text = "2018-10-30 08:42:33"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
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

extension TrainingStatusTableViewCell {
    func setUpUI() {
        self.contentView.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(20)
        }
        
        self.contentView.addSubview(descLabel)
        self.descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
    }
}
