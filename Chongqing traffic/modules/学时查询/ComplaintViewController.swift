//
//  ComplaintViewController.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/17.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class ComplaintViewController: BaseViewController {
    
    var selectObject:String = ""
    
    
    var dicInfo:NSDictionary?
    
    lazy var complainView: ComplaintView = {
        let view = ComplaintView.init(frame: CGRect.zero)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "学时记录详情"
        
        setUpUI()
    }
    
    func setUpUI() {
        self.view.addSubview(complainView)
        self.complainView.snp.makeConstraints { (make) in
            make.top.equalTo(navigationBarHeight)
            make.left.right.bottom.equalToSuperview()
        }
        self.complainView.complaintSelectObjectClick = { [weak self] in
            //选择投诉对象
            print("选择投诉对象")
            self?.view.endEditing(true)
            let pickerView = ComplaintObjectPickerView()
            if self?.complainView.selectObjectLabel.text != "请选择投诉对象" {
                pickerView.selectedObject = self?.complainView.selectObjectLabel.text
            }
            pickerView.pickerViewWithComplaintObjectBlock(complaintObjectBlock: { [weak self](object) in
                self?.selectObject = object
                self?.complainView.selectObjectLabel.text = object
                self?.complainView.selectObjectLabel.textColor = MainTextColor
                if self?.complainView.textView.text != "" && self?.complainView.textView.text != nil {
                    self?.complainView.complaintButton.backgroundColor = MainYellowColor
                    self?.complainView.complaintButton.isUserInteractionEnabled = true
                }else {
                    self?.complainView.complaintButton.backgroundColor = UIColor(r: 255, g: 229, b: 147)
                    self?.complainView.complaintButton.isUserInteractionEnabled = false
                }
            })
            /// 设置pickerView字体颜色和大小
            pickerView.pickerLabelFont = UIFont.systemFont(ofSize: 20)
            pickerView.pickerLabelTextCoclor = MainTextColor
        }
        
        self.complainView.complaintClick = { [weak self] in
            self?.isEditing = false
            
            //一键投诉
            var params = [String : Any]()
    
            let id = self?.dicInfo?.object(forKey: "periodId") as? String
            params["pid"] = Int(id ?? "0")
            
            var objectId:String = ""
            if self?.selectObject == "教练" {
                objectId = self?.dicInfo?.object(forKey: "coanum") as? String ?? ""
                params["type"] = 1
            }else if self?.selectObject == "驾校" {
                objectId = self?.dicInfo?.object(forKey: "inscode") as? String ?? ""
                params["type"] = 2
            }
            
            params["objenum"] = objectId
            params["content"] = self?.complainView.textView.text
            
            NetWorkRequest(.complaint(params: params), completion: { (result) -> (Void) in
                
                let code = result.object(forKey: "code") as! Int
                if code == 0{
                    print("投诉成功")
                    self?.navigationController?.popViewController(animated: true)
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
}
