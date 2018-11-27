//
//  InsuranceBuyView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/21.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

// 创建闭包
typealias SureOrderBtnClick = ((Int) -> (Void))

class InsuranceBuyView: UIView {
    
    var products:Array<Any>? = nil
    
    var sureOrderBtnClick : SureOrderBtnClick?
    var selected:PartButton? = nil
    var insuranceId = 0
    
    
    lazy var orderInfoView: InsuranceOrderInfoView = {
        let view = InsuranceOrderInfoView()
        return view
    }()
    
    lazy var fillInfoView: InsuranceOrderUserInfoView = {
        let view = InsuranceOrderUserInfoView()
        return view
    }()
    
    lazy var sureBtn: BaseButton = {
        let button = BaseButton()
        button.titleLabel?.font = KUIFont16
        button.setTitle("确定", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MainTitleColor
        button.addTarget(self, action: #selector(sureButtonClicked), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func sureButtonClicked() {
        guard let sureOrderBtnClick = sureOrderBtnClick else { return }
        sureOrderBtnClick(insuranceId)
    }
    
    func setInsuranceProducts(products:Array<Any>?, from part:Int) {
        
        guard let products = products else { return }
        
        self.products = products
        
        var orginX:CGFloat = 0
        var orginY:CGFloat = 0
        let buttonHeight:CGFloat = 24
        let space:CGFloat = 10
        
        for i in 0..<products.count {
            let product:NSDictionary? = products[i] as?NSDictionary
            let button = PartButton()
            
            button.tag = 100 + i
            
            var typeInt = product?.object(forKey: "subject") as? Int
            if typeInt == nil || typeInt == 0 {
                typeInt = 1
            }
            var typeName:String = ""
            if typeInt == 1 {
                typeName = "科目一"
            }else if typeInt == 2 {
                typeName = "科目二"
            }else if typeInt == 3 {
                typeName = "科目三"
            }else if typeInt == 4 {
                typeName = "科目四"
            }else if typeInt == 5 {
                typeName = "全科目套餐"
            }
            if typeInt == part {
                button.isSelected = true
                button.layer.borderColor = MainYellowColor.cgColor
                selected = button
                insuranceId = product?.object(forKey: "id") as? Int ?? 0
                //渲染保险相关信息视图
                let photoUrl = product?.object(forKey: "images") as? String
                orderInfoView.ensureImageView.kf.setImage(with: URL(string: photoUrl ?? ""), placeholder: UIImage.init(named: "bg_default_img169"), options: nil, progressBlock: nil, completionHandler: nil)
                orderInfoView.nameLabel.text = product?.object(forKey: "name") as? String
                
                let days = product?.object(forKey: "validTime") as? Int
                orderInfoView.validDateLabel.text = "\(days ?? 0)天"
                
                let price = product?.object(forKey: "price") as? Double
                orderInfoView.moneyLabel.text = "￥\(price ?? 0)"
                
                var explain = product?.object(forKey: "insureNotice") as? String
                if explain == nil {
                    explain = ""
                }
                explain = explain?.replacingOccurrences(of: "<p>", with: "<span>")
                explain = explain?.replacingOccurrences(of: "</p>", with: "</span>")
                do{
                    let attrStr = try NSMutableAttributedString(data: explain!.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
                    
                    orderInfoView.explainLabel.attributedText = attrStr
                }catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            
            button.setTitle(typeName, for: .normal)
            button.addTarget(self, action: #selector(partButtonClicked(button:)), for: .touchUpInside)
            
            var btnWidth = sizeWithText(text: typeName as NSString, font: KUIFont12, size: CGSize.init(width: KScreenWidth - 80, height: buttonHeight))
            if btnWidth+20 > KScreenWidth - 80 {
                btnWidth = KScreenWidth - 100
            }
            if orginX + btnWidth + 20 > KScreenWidth - 80 {
                orginX = 0
                orginY = orginY + buttonHeight + space
            }
            
            fillInfoView.insuranceBgView.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.left.equalTo(orginX)
                make.top.equalTo(orginY)
                make.width.equalTo(btnWidth + 20)
                make.height.equalTo(buttonHeight)
                if i == products.count - 1 {
                    make.bottom.equalToSuperview()
                }
            }
            
            orginX = orginX + btnWidth + 20 + space
        }
    }
    
    @objc func partButtonClicked(button:UIButton) {
        selected?.isSelected = false
        selected?.layer.borderColor = KUIColorLine.cgColor
        
        button.isSelected = true
        button.layer.borderColor = MainYellowColor.cgColor
        selected = button as? PartButton
        
        let product:NSDictionary? = self.products?[button.tag - 100] as? NSDictionary
        insuranceId = product?.object(forKey: "id") as? Int ?? 0
        //渲染保险相关信息视图
        let photoUrl = product?.object(forKey: "images") as? String
        orderInfoView.ensureImageView.kf.setImage(with: URL(string: photoUrl ?? ""), placeholder: UIImage.init(named: "bg_default_img169"), options: nil, progressBlock: nil, completionHandler: nil)
        orderInfoView.nameLabel.text = product?.object(forKey: "name") as? String
        
        let days = product?.object(forKey: "validTime") as? Int
        orderInfoView.validDateLabel.text = "\(days ?? 0)天"
        
        let price = product?.object(forKey: "price") as? Double
        orderInfoView.moneyLabel.text = "￥\(price ?? 0)"
        
        var explain = product?.object(forKey: "insureNotice") as? String
        if explain == nil {
            explain = ""
        }
        explain = explain?.replacingOccurrences(of: "<p>", with: "<span>")
        explain = explain?.replacingOccurrences(of: "</p>", with: "</span>")
        do{
            let attrStr = try NSMutableAttributedString(data: explain!.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            orderInfoView.explainLabel.attributedText = attrStr
        }catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    /**
     * 计算字符串长度
     */
    func sizeWithText(text: NSString, font: UIFont, size: CGSize) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size.width;
    }
}

extension InsuranceBuyView {
    func setUpUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 4
        //添加阴影
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        //zero表示不偏移
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        
        self.addSubview(orderInfoView)
        self.orderInfoView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        self.addSubview(fillInfoView)
        self.fillInfoView.snp.makeConstraints { (make) in
            make.top.equalTo(self.orderInfoView.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        self.addSubview(sureBtn)
        self.sureBtn.snp.makeConstraints { (make) in
            make.left.height.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(self.fillInfoView.snp.bottom).offset(22)
            make.bottom.equalTo(-(40+safeAreaBottomHeight))
        }
    }
}
