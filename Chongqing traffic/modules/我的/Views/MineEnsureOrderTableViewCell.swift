//
//  MineEnsureOrderTableViewCell.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/20.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineEnsureOrderTableViewCell: UITableViewCell {
    
    lazy var orderInfoView: MineEnsureOrderInfoView = {
        let view = MineEnsureOrderInfoView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI() {
        self.contentView.addSubview(orderInfoView)
        self.orderInfoView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(4)
            make.bottom.equalTo(-4)
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

extension MineEnsureOrderTableViewCell {
    func setData(dicInfo:NSDictionary?) {
        orderInfoView.orderNumberLabel.text = "订单号：\(dicInfo?.object(forKey: "orderId") ?? "")"
        
        let orderStatus = dicInfo?.object(forKey: "orderStatus") as? String
        let policyStatus = dicInfo?.object(forKey: "policyStatus") as? String
        
        if orderStatus == "UNPAID" {
            orderInfoView.orderStatusLabel.text = "未支付"
        }else {
            if policyStatus == "UNHANDLED" {
                orderInfoView.orderStatusLabel.text = "待处理"
            }else if policyStatus == "VALID" {
                orderInfoView.orderStatusLabel.text = "保障中"
            }else if policyStatus == "INVALID" {
                orderInfoView.orderStatusLabel.text = "保障完成"
            }
        }
        
        let policyImageUrl = dicInfo?.object(forKey: "images") as? String
        orderInfoView.ensureImageView.kf.setImage(with: URL(string: policyImageUrl ?? ""), placeholder: UIImage.init(named: "bg_default_img169"), options: nil, progressBlock: nil, completionHandler: nil)
        
        orderInfoView.nameLabel.text = dicInfo?.object(forKey: "insuranceProductName") as? String
        orderInfoView.userLabel.text = dicInfo?.object(forKey: "userName") as? String
        orderInfoView.validDateLabel.text = "\(dicInfo?.object(forKey: "validTime") ?? 0)天"
        orderInfoView.codeLabel.text = "\(dicInfo?.object(forKey: "policyOrderId") ?? "")"
        
        var starDataStr = dicInfo?.object(forKey: "startTime") as? String
        var endDateStr = dicInfo?.object(forKey: "endTime") as? String
        if starDataStr == nil || starDataStr == "" {
            starDataStr = "--"
        }
        if endDateStr == nil || endDateStr == "" {
            endDateStr = "--"
        }
        let attributeStr = NSMutableAttributedString.init(string: (starDataStr! + " 至 " + endDateStr!))
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: MainTextColor]
        
        attributeStr.addAttributes(multipleAttributes, range: NSRange.init(location: (starDataStr?.count)!, length: 3))
        orderInfoView.termDateLabel.attributedText = attributeStr
    }
}
