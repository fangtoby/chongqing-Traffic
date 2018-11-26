//
//  MineTrainInfoViewController.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/18.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineTrainInfoViewController: BaseViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeigth))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        
        return contentView
    }()
    
    lazy var mineInfoView: MineInfoView = {
        let view = MineInfoView()
        return view
    }()
    
    lazy var mineTrainInfoView: MineTrainInfoView = {
        let view = MineTrainInfoView()
        return view
    }()
    
    var currentPart:String?    
    var dataSource = [Any]()
    var userInfoDic:NSDictionary?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "我的培训信息"
        
        userInfoDic = UserDefaults.standard.object(forKey: userInfo) as? NSDictionary
        
        setUpUI()
        
        reloadDataView()
    }
    
    func setUpUI() {
        self.view.addSubview(scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.scrollView.addSubview(contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.bottom.equalTo(self.scrollView)
        }
        
        self.contentView.addSubview(mineInfoView)
        self.mineInfoView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(4)
            make.height.equalTo(95)
        }
        
        mineInfoView.isUserInteractionEnabled = true
        mineInfoView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(mineInfoViewClick)))
        
        self.contentView.addSubview(mineTrainInfoView)
        self.mineTrainInfoView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.mineInfoView.snp.bottom)
            make.bottom.equalTo(mineTrainInfoView.currentLabel.snp.bottom).offset(30)
        }
    }
    
    func reloadDataView() {
        var placeholder:UIImage
        
        let sexStr = userInfoDic?.valueAsString(forKey: "sex")
        let sex = Int(sexStr ?? "1")
        if sex == 2{
            placeholder = UIImage.init(named: "icon_default_woman")!
            mineInfoView.sexImageView.image = UIImage.init(named: "icon_sex_woman")
        }else {
            placeholder = UIImage.init(named: "icon_default_man")!
            mineInfoView.sexImageView.image = UIImage.init(named: "icon_sex_man")
        }
        
        let logoImageUrl = userInfoDic?.valueAsString(forKey: "photourl")
        let logoUrl = URL(string: logoImageUrl ?? "")
        mineInfoView.userLogoImageView.kf.setImage(with: logoUrl, placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: nil)
        mineInfoView.nameLabel.text = userInfoDic?.valueAsString(forKey: "name")
        
        mineInfoView.descLabel.text = "目前正在\(userInfoDic?.valueAsString(forKey: "schName") ?? "")"+"学习\(userInfoDic?.valueAsString(forKey: "traintype") ?? "")技能"
        
        var codeStr = userInfoDic?.valueAsString(forKey: "idcard")
        codeStr = codeStr?.cardnumbersEncryption(cardString: codeStr ?? "")
        mineTrainInfoView.codeLabel.text = codeStr
        
        mineTrainInfoView.schoolLabel.text = userInfoDic?.valueAsString(forKey: "schName")
        
        var phone = userInfoDic?.valueAsString(forKey: "phone")
        phone = phone?.phoneNumberEncryption(string: phone ?? "")
        mineTrainInfoView.phoneLabel.text = phone
        
        mineTrainInfoView.platformLabel.text = userInfoDic?.valueAsString(forKey: "platName")
        
        let timeInterval = userInfoDic?.object(forKey: "applydate") as? Double
        let date = Date.getNowDateFromatAnDate(Date(timeIntervalSince1970: (timeInterval ?? 0)/1000))
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr = formatter.string(from: date)
        mineTrainInfoView.dateLabel.text = dateStr
        
        let status = userInfoDic?.valueAsString(forKey: "graduation")
        if status == "1" {
             mineTrainInfoView.statusLabel.text = "已结业"
        }else {
            mineTrainInfoView.statusLabel.text = "未结业"
        }
        
        if self.currentPart == "1" {
            mineTrainInfoView.currentLabel.text = "第一部分"
        }else if self.currentPart == "2" {
            mineTrainInfoView.currentLabel.text = "第二部分"
        }else if self.currentPart == "3" {
            mineTrainInfoView.currentLabel.text = "第三部分"
        }else if self.currentPart == "4" {
            mineTrainInfoView.currentLabel.text = "第四部分"
        }else {
            mineTrainInfoView.currentLabel.text = ""
        }
    }
    
    @objc func mineInfoViewClick() {
        let mineInfoVC = MineInfoViewController()
        self.navigationController?.pushViewController(mineInfoVC, animated: true)
    }
}
