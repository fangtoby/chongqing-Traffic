//
//  PeriodRecordNoDataView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/19.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

// 创建闭包
//typealias FreshBtnClick = () -> (Void)
protocol ZLPlaceHolderDelegate: class {
    func emptyOverlayClicked()
}

class PeriodRecordNoDataView: UIView {
    
    weak var delegate : ZLPlaceHolderDelegate?
    
//    var freshBtnClick : FreshBtnClick?
    
    lazy var bgView: UIView = {
        let view = UIView()
//        view.backgroundColor = .cyan
        return view
    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "icon_no_data")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont12
        label.text = "一点痕迹也没有"
        label.textColor = AssistColor
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var freshButton: UIButton = {
        let button = UIButton()
        button.setTitle("刷新", for: .normal)
        button.titleLabel?.font = KUIFont12
        button.setTitleColor(MainBlueColor, for: .normal)
        button.setTitleColor(AssistColor, for: .highlighted)
        button.addTarget(self, action: #selector(freshButtonClicked), for: .touchUpInside)
        return button
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func freshButtonClicked() {
        delegate?.emptyOverlayClicked()
    }
}

extension PeriodRecordNoDataView {
    func setUpUI() {
        self.addSubview(bgView)
        self.bgView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-80)
            make.left.right.equalToSuperview()
        }
        
        self.bgView.addSubview(imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.bgView.addSubview(titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
        }
        
        self.bgView.addSubview(freshButton)
        self.freshButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(37)
            make.bottom.equalToSuperview()
        }
    }
}
