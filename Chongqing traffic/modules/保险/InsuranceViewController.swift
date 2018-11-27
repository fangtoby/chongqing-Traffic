//
//  InsuranceViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/21.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit
import MBProgressHUD

class InsuranceViewController: BaseViewController {
    
    var insuranceId:Int = 0
    
    var userInfoDic:NSDictionary?
    var part:Int = 0
    var products:Array<Any>? = nil
    
    lazy var sureBtn: BaseButton = {
        let button = BaseButton()
        button.titleLabel?.font = KUIFont16
        button.setTitle("确认无误", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MainTitleColor
        button.addTarget(self, action: #selector(sureButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var userInfoView: InsuranceUserInfoView = {
        let view = InsuranceUserInfoView()
        return view
    }()
    
    lazy var insuranceInfoView: InsuranceInfoView = {
        let view = InsuranceInfoView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "学车无忧险"
        
        userInfoDic = UserDefaults.standard.object(forKey: userInfo) as? NSDictionary
        
        setUpUI()
        self.userInfoView.setData(dicInfo:userInfoDic)
    }
    
    func setUpUI() {
        self.view.addSubview(sureBtn)
        self.sureBtn.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.bottom.equalTo(-(40 + safeAreaBottomHeight))
            make.height.equalTo(40)
        }
        
        self.view.addSubview(userInfoView)
        self.userInfoView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(navigationBarHeight)
        }
        
        self.view.addSubview(insuranceInfoView)
        self.insuranceInfoView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.userInfoView.snp.bottom)
            make.bottom.equalTo(self.sureBtn.snp.top).offset(-20)
        }
    }
    
    @objc func sureButtonClicked() {
        let params = [String : Any]()
        
        NetWorkRequest(.insuranceProduct(params:params), completion: { [weak self](result) -> (Void) in
            let code = result.object(forKey: "code") as! Int
            if code == 0{
                self?.products = result.object(forKey: "data") as? Array
                //确认信息
                let insuranceBuyView = InsuranceBuyView()
                insuranceBuyView.setInsuranceProducts(products: self?.products, from: (self?.part ?? 0) + 1)
                
                self?.view.addSubview(insuranceBuyView)
                insuranceBuyView.snp.makeConstraints { (make) in
                    make.left.right.bottom.equalToSuperview()
                }
            
                insuranceBuyView.orderInfoView.closeBtnClick = {
                    insuranceBuyView.removeFromSuperview()
                }
                
                insuranceBuyView.sureOrderBtnClick = { [weak self] (id) in
                    if insuranceBuyView.fillInfoView.codeTextField.text == "" {
                        MBProgressHUD.showInfo("请输入银行卡号")
                        return
                    }else if insuranceBuyView.fillInfoView.bankTextField.text == "" {
                        MBProgressHUD.showInfo("请输入开户行")
                        return
                    }
                    var params = [String : Any]()
                    params["productId"] = id
                    params["bankCardNumber"] = insuranceBuyView.fillInfoView.codeTextField.text
                    params["bankName"] = insuranceBuyView.fillInfoView.bankTextField.text
                    MBProgressHUD.showWait("生成订单，请稍后...")
                    NetWorkRequest(.insuranceOrder(params: params), completion: { (result) -> (Void) in
                        insuranceBuyView.removeFromSuperview()
                        let code = result.object(forKey: "code") as! Int
                        if code == 0 {
                            let dicInfo:NSDictionary = result.object(forKey: "data") as! NSDictionary
                            
                            let orderId = dicInfo.object(forKey: "orderId") as? Int
                            
                            let unpaid = dicInfo.object(forKey: "unpaid") as? Bool
                            if unpaid == true {
                                let alertView = ZLAlertView()
                                alertView.titleLabel.text = "注意"
                                alertView.messegeLabel.text = "系统检测到您有相同类型的未支付订单，您可以选择："
                                alertView.sureButton.setTitle("去支付", for: .normal)
                                alertView.showView()
                                alertView.sureBtnClick = { [weak self] in
                                    //跳转到支付页面
                                    
                                }
                            }else {
                                let insurancePayVC = InsurancePayViewController()
                                insurancePayVC.orderId = orderId ?? 0
                                self?.navigationController?.pushViewController(insurancePayVC, animated: true)
                            }
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
    
    func sureOrderClicked(id:Int) {
        
    }
}
