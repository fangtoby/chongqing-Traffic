//
//  PeriodRecordDetailViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/16.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class PeriodRecordDetailViewController: BaseViewController {
    
    var dicInfo:NSDictionary? = nil
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: self.view.bounds)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    lazy var contentView: UIView = {
        let contentView = UIView()
        
        return contentView
    }()
    
    lazy var recordDetailInfoView: PeriodRecordDetailInfoView = {
        let view = PeriodRecordDetailInfoView.init(frame: CGRect.zero)
        
        return view
    }()
    
    lazy var recordDetailImagesView: PeriodRecordDetailImagesView = {
        let view = PeriodRecordDetailImagesView.init(frame: CGRect.zero)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "学时记录详情"
        // Do any additional setup after loading the view.
        setUpUI()
        
        self.recordDetailInfoView.setUpData(dicInfo:self.dicInfo)
        setImagesData()
        loadIsComplaintData()
    }
    
    func loadIsComplaintData() {
        let id = self.dicInfo?.object(forKey: "periodId") as? String
        var params = [String : Any]()
        params["pid"] = Int(id ?? "0")
        
        NetWorkRequest(.complaintStatus(params: params), completion: { [weak self](result) -> (Void) in
            
            let code = result.object(forKey: "code") as! Int
            if code == 0{
                guard let complaint = result.object(forKey: "data") as? Bool else { return }
                if complaint == true {
                    self?.recordDetailInfoView.isComplaint(complaint:true)
                }else {
                    self?.recordDetailInfoView.isComplaint(complaint:false)
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
    
    func setImagesData() {
        let beiginImageUrl = self.dicInfo?.object(forKey: "url1") as? String
        let trainingImageUrl = self.dicInfo?.object(forKey: "url2") as? String
        let endImageUrl = self.dicInfo?.object(forKey: "url3") as? String
        
        self.recordDetailImagesView.beginImageView.kf.setImage(with: URL(string: beiginImageUrl ?? ""))
        self.recordDetailImagesView.trainingImageView.kf.setImage(with: URL(string: trainingImageUrl ?? ""))
        self.recordDetailImagesView.endImageView.kf.setImage(with: URL(string: endImageUrl ?? ""))
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
        
        self.contentView.addSubview(recordDetailInfoView)
        self.recordDetailInfoView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        self.contentView.addSubview(recordDetailImagesView)
        self.recordDetailImagesView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.recordDetailInfoView.snp.bottom)
//            make.bottom.equalTo(self.recordDetailImagesView.beginLabel.snp.bottom).offset(20)
        }
        
        self.recordDetailInfoView.complaintBtnClick = { [weak self] in
            //一键投诉
            let complainVC = ComplaintViewController()
            complainVC.dicInfo = self?.dicInfo
            self?.navigationController?.pushViewController(complainVC, animated: true)
        }
    }
    
    override func reLogin() {
        self.recordDetailInfoView.setUpData(dicInfo:self.dicInfo)
        setImagesData()
        loadIsComplaintData()
    }
}
