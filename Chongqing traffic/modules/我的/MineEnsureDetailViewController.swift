//
//  MineEnsureDetailViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/20.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineEnsureDetailViewController: BaseViewController {
    
    var orderId:Int = 0
    var dicInfo:NSDictionary?
    
    lazy var ensureInfoView: MineEnsureOrderInfoView = {
        let view = MineEnsureOrderInfoView()
        return view
    }()
    
    lazy var applyPaymentBtn: BaseButton = {
        let button = BaseButton()
//        button.isUserInteractionEnabled = false
        button.titleLabel?.font = KUIFont16
        button.setTitle("申请理赔", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MainTitleColor
        button.addTarget(self, action: #selector(applyPaymentButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var detailInfoView: MineEnsureDetailView = {
        let view = MineEnsureDetailView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "保障详情"
        // Do any additional setup after loading the view.
        setUpUI()
        
        loadData()
    }
    
    func loadData() {
        NetWorkRequest(.insuranceOrderDetail(orderId:orderId), completion: { [weak self](result) -> (Void) in
            let code = result.object(forKey: "code") as! Int
            if code == 0 {
               self?.dicInfo = result.object(forKey: "data") as? NSDictionary
                
                self?.applyPaymentBtn.isUserInteractionEnabled = true
                self?.setData(dicInfo: self?.dicInfo)
            }else if code == 402 {
                UserDefaults.standard.removeObject(forKey: isLogin)
                UserDefaults.standard.removeObject(forKey: loginInfo)
                let loginVC = LoginViewController()
                loginVC.reLoginDelegate = self
                loginVC.isFirstLogin = false
                self?.present(loginVC, animated: true, completion: nil)
            }
        })
    }
    
    func setUpUI() {
        self.view.addSubview(ensureInfoView)
        self.ensureInfoView.snp.makeConstraints { (make) in
            make.top.equalTo(4 + navigationBarHeight)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        self.view.addSubview(applyPaymentBtn)
        self.applyPaymentBtn.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.bottom.equalTo(-(40 + safeAreaBottomHeight))
            make.height.equalTo(40)
        }
        
        self.view.addSubview(detailInfoView)
        self.detailInfoView.snp.makeConstraints { (make) in
            make.top.equalTo(self.ensureInfoView.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.applyPaymentBtn.snp.top).offset(-20)
        }
    }
    
    @objc func applyPaymentButtonClicked() {
        //申请理赔
        let applyPaymentVC = MineApplyPaymentViewController()
        applyPaymentVC.dicInfo = self.dicInfo
        self.navigationController?.pushViewController(applyPaymentVC, animated: true)
    }
    
    override func reLogin() {
        loadData()
    }
}

extension MineEnsureDetailViewController {
    func setData(dicInfo:NSDictionary?) {
        
        ensureInfoView.orderNumberLabel.text = "订单号：\(dicInfo?.object(forKey: "orderId") ?? "")"
        
        let orderStatus = dicInfo?.object(forKey: "orderStatus") as? String
        let policyStatus = dicInfo?.object(forKey: "policyStatus") as? String
        
        if orderStatus == "UNPAID" {
            ensureInfoView.orderStatusLabel.text = "未支付"
        }else {
            if policyStatus == "UNHANDLED" {
                ensureInfoView.orderStatusLabel.text = "待处理"
            }else if policyStatus == "VALID" {
                ensureInfoView.orderStatusLabel.text = "保障中"
            }else if policyStatus == "INVALID" {
                ensureInfoView.orderStatusLabel.text = "保障完成"
            }
        }
        
        let policyImageUrl = dicInfo?.object(forKey: "images") as? String
        ensureInfoView.ensureImageView.kf.setImage(with: URL(string: policyImageUrl ?? ""), placeholder: UIImage.init(named: "bg_default_img169"), options: nil, progressBlock: nil, completionHandler: nil)
        
        ensureInfoView.nameLabel.text = dicInfo?.object(forKey: "insuranceProductName") as? String
        ensureInfoView.userLabel.text = dicInfo?.object(forKey: "userName") as? String
        ensureInfoView.validDateLabel.text = "\(dicInfo?.object(forKey: "validTime") ?? 0)天"
        ensureInfoView.codeLabel.text = "\(dicInfo?.object(forKey: "policyNum") ?? "")"
        
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
        ensureInfoView.termDateLabel.attributedText = attributeStr
        
        detailInfoView.trainTypeLabel.text = dicInfo?.object(forKey: "drivingPermitted") as? String
        detailInfoView.cardCodeLabel.text = dicInfo?.object(forKey: "bankDetail") as? String
        let payStatus = dicInfo?.object(forKey: "compensationStatus") as? String
        if payStatus == "NON" {
            detailInfoView.statusLabel.text = "未发起"
        }else if payStatus == "CHECKING" {
            detailInfoView.statusLabel.text = "核赔中"
        }else if payStatus == "CHECK_OVER" {
            detailInfoView.statusLabel.text = "核赔完成"
        }else if payStatus == "COMPENSATED" {
            detailInfoView.statusLabel.text = "已赔付"
        }else if payStatus == "REJECT" {
            detailInfoView.statusLabel.text = "拒绝赔付"
        }
        
        guard let payRecord = dicInfo?.object(forKey: "records") as? String else {
            return
        }
        
        let faildArray =  payRecord.components(separatedBy: ";")
        detailInfoView.setDataSource(dataSource: faildArray)
    }
}
