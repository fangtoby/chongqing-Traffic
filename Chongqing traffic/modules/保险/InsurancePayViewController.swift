//
//  InsurancePayViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/21.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class InsurancePayViewController: BaseViewController {
    
    var orderId:Int = 0
    var isFromList:Bool = false
    var isBuyFromList = false
    
    lazy var orderUserInfoView: MineApplyPaymentInfoView = {
        let view = MineApplyPaymentInfoView()
        return view
    }()
    
    lazy var payView: InsurancePayInfoView = {
        let view = InsurancePayInfoView()
        return view
    }()
    
    lazy var payBtn: BaseButton = {
        let button = BaseButton()
        button.titleLabel?.font = KUIFont16
        button.setTitle("去支付", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MainTitleColor
        button.addTarget(self, action: #selector(goPayBtnClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "订单详情"
        
        setUpUI()
        loadData()
    }
    
    func loadData() {
        NetWorkRequest(.payOrderDetail(orderId: orderId), completion: { [weak self](result) -> (Void) in
            let code = result.object(forKey: "code") as! Int
            if code == 0 {
                let dicInfo = result.object(forKey: "data") as? NSDictionary
                self?.setData(dicInfo: dicInfo)
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
        self.view.addSubview(orderUserInfoView)
        self.orderUserInfoView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(navigationBarHeight)
        }
        
        self.view.addSubview(payView)
        self.payView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.orderUserInfoView.snp.bottom)
        }
        
        self.view.addSubview(payBtn)
        self.payBtn.snp.makeConstraints { (make) in
            make.left.height.equalTo(40)
            make.right.equalTo(-40)
            make.bottom.equalTo(-(40 + safeAreaBottomHeight))
        }
    }
    
    @objc func goPayBtnClicked() {
        //去支付
        var params = [String : Any]()
        params["applicationCode"] = "CQJT_APP"
        if payView.aliPayBtn.isSelected == true {
            params["payType"] = "ZFB"
        }else {
            params["payType"] = "WX"
        }
        params["orderId"] = orderId
        NetWorkRequest(.pay(params: params), completion: { [weak self](result) -> (Void) in
            let code = result.object(forKey: "code") as! Int
            if code == 0 {
                print(result)
                let order = result.object(forKey: "data") as! String
                PayManager.shareInstance.pay(order: order, callback: { (stateCode, message) -> (Void) in
                    print(stateCode)
                    print(message)
                    if (stateCode == PayStateCode.PayStateCodeSuccess) {
                        let alertView = ZLAlertView()
                        alertView.titleLabel.text = "支付成功"
                        alertView.messegeLabel.text = "即将跳转到我的保障信息界面可查看本次购买的学车无忧险"
                        alertView.isHidenCancle()
                        alertView.sureButton.setTitle("关闭", for: .normal)
                        alertView.showView()
                        alertView.sureBtnClick = {
                            if self?.isFromList == true {
                                self?.navigationController?.popViewController(animated: true)
                            }else {
                                if self?.isBuyFromList == true {
                                    let index = self?.navigationController?.viewControllers.count
                                    self?.navigationController?.popToViewController((self?.navigationController?.viewControllers[index! - 3])!, animated: true)
                                }else {
                                    let ensureVC = MineEnsureViewController()
                                    ensureVC.isFromPay = true
                                    self?.navigationController?.pushViewController(ensureVC, animated: true)
                                }
                            }
                        }
                    }else {
                        let alertView = ZLAlertView()
                        alertView.titleLabel.text = "支付失败"
                        alertView.messegeLabel.text = "即将跳转到我的保障信息界面可查看学车无忧险订单并进行支付"
                        alertView.sureButton.setTitle("关闭", for: .normal)
                        alertView.isHidenCancle()
                        alertView.showView()
                        alertView.sureBtnClick = {
                            if self?.isFromList == true {
                                self?.navigationController?.popViewController(animated: true)
                            }else {
                                if self?.isBuyFromList == true {
                                    let index = self?.navigationController?.viewControllers.count
                                    self?.navigationController?.popToViewController((self?.navigationController?.viewControllers[index! - 3])!, animated: true)
                                }else {
                                    let ensureVC = MineEnsureViewController()
                                    ensureVC.isFromPay = true
                                    self?.navigationController?.pushViewController(ensureVC, animated: true)
                                }
                            }
                        }
                    }
                    
                })
                
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
}
extension InsurancePayViewController {
    func setData(dicInfo:NSDictionary?) {
        orderUserInfoView.nameLabel.text = dicInfo?.object(forKey: "userName") as? String
        
        var cardNumberStr = dicInfo?.object(forKey: "cardCode") as? String
        cardNumberStr = cardNumberStr?.cardnumbersEncryption(cardString: cardNumberStr ?? "")
        orderUserInfoView.codeLabel.text = cardNumberStr
        
        orderUserInfoView.trainTypeLabel.text = dicInfo?.object(forKey: "drivingPermitted") as? String
        
        var phoneStr = dicInfo?.object(forKey: "phone") as? String
        phoneStr = phoneStr?.phoneNumberEncryption(string: phoneStr ?? "")
        orderUserInfoView.phoneNumberLabel.text = phoneStr
        
        orderUserInfoView.cardCodeLabel.text = dicInfo?.object(forKey: "bankDetail") as? String
        
        payView.insuranceLabel.text = "\(dicInfo?.object(forKey: "insuranceProductName") ?? "") 考试不通过赔付补考费用"
        payView.orderMoneyLabel.text = "￥\(dicInfo?.object(forKey: "price") ?? 0)"
    }
}
