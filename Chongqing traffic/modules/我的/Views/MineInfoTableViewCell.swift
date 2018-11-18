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
    lazy var mineInfoView:MineInfoView = {
       let view = MineInfoView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI() {
        self.contentView.addSubview(mineInfoView)
        self.mineInfoView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(95)
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
