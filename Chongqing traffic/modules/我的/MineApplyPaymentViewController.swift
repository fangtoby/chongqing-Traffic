//
//  MineApplyPaymentViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/20.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit
import Photos
import CLImagePickerTool
import MBProgressHUD

class MineApplyPaymentViewController: BaseViewController {
    
    var assets:Array<PHAsset> = []
    var images:Array<UIImage> = []
    var imagePaths = [String]()
    
    var dicInfo:NSDictionary?
    
    // 如果是单独访问相机，一定要声明为全局变量
    let imagePickTool = CLImagePickerTool()
    
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
    
    lazy var applyPayInfoView: MineApplyPaymentInfoView = {
        let view = MineApplyPaymentInfoView()
        return view
    }()
    
    lazy var applyPaymentProveView: MineApplyPaymentProveView = {
        let view = MineApplyPaymentProveView()
        return view
    }()
    
    lazy var commitButton: BaseButton = {
        let button = BaseButton()
        button.titleLabel?.font = KUIFont16
        button.setTitle("提交申请", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = MainTitleColor
        button.addTarget(self, action: #selector(commitButtonClicked), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "申请理赔"
        // Do any additional setup after loading the view.
        setUpUI()
        
        setData()
    }
    
    func setData() {
        applyPayInfoView.nameLabel.text = dicInfo?.object(forKey: "userName") as? String
        
        var cardNumberStr = dicInfo?.object(forKey: "cardCode") as? String
        cardNumberStr = cardNumberStr?.cardnumbersEncryption(cardString: cardNumberStr ?? "")
        applyPayInfoView.codeLabel.text = cardNumberStr
        
        applyPayInfoView.trainTypeLabel.text = dicInfo?.object(forKey: "drivingPermitted") as? String
        
        var phoneStr = dicInfo?.object(forKey: "phone") as? String
        phoneStr = phoneStr?.phoneNumberEncryption(string: phoneStr ?? "")
        applyPayInfoView.phoneNumberLabel.text = phoneStr
        
        applyPayInfoView.cardCodeLabel.text = dicInfo?.object(forKey: "bankDetail") as? String
    }
    
    func setUpUI() {
        self.view.addSubview(commitButton)
        self.commitButton.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.bottom.equalTo(-(40 + safeAreaBottomHeight))
            make.height.equalTo(40)
        }
        
        self.view.addSubview(scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.commitButton.snp.top).offset(-20)
        }
        
        self.scrollView.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.bottom.equalToSuperview()
        }
        
        self.contentView.addSubview(applyPayInfoView)
        self.applyPayInfoView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(navigationBarHeight)
        }
        
        self.contentView.addSubview(applyPaymentProveView)
        self.applyPaymentProveView.snp.makeConstraints { (make) in
            make.top.equalTo(self.applyPayInfoView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        //添加照片
        self.applyPaymentProveView.addImageButtonClick = { [weak self] in
            self?.imagePickTool.cameraOut = true
            if (self?.assets.count)! < 6 {
                self?.imagePickTool.setupImagePickerWith(MaxImagesCount: (6 - (self?.assets.count)!), superVC: self!) { (selectAssets,cutImage) in
                    print("返回的asset数组是\(selectAssets)")
                    
                    for asset in selectAssets {
                        self?.assets.append(asset)
                    }
                    
                    // 获取原图，异步
                    // scale 指定压缩比
                    // 内部提供的方法可以异步获取图片，同步获取的话时间比较长，不建议！，如果是iCloud中的照片就直接从icloud中下载，下载完成后返回图片,同时也提供了下载失败的方法
                    CLImagePickerTool.convertAssetArrToOriginImage(assetArr: selectAssets, scale: 0.1, successClouse: {[weak self] (image,assetItem) in
                        
                        self?.images.append(image)
                        
                        }, failedClouse: { () in
                            
                    })
                    self?.applyPaymentProveView.images = (self?.images)!
                }
            }
        }
        //删除照片
        self.applyPaymentProveView.deleteImageButtonClick = { [weak self] (index) in
            self?.images.remove(at: index)
            self?.assets.remove(at: index)
            self?.applyPaymentProveView.images = (self?.images)!
        }
        //重选照片
        self.applyPaymentProveView.reselecteImageButtonClick = {[weak self] (index) in
            self?.imagePickTool.singleImageChooseType = .singlePicture
            self?.imagePickTool.cameraOut = true
            self?.imagePickTool.setupImagePickerWith(MaxImagesCount: 1, superVC: self!) { (selectAssets,editorImage) in
                print("返回的asset是\(selectAssets)")
                
                self?.assets.remove(at: index)
                for asset in selectAssets {
                    self?.assets.insert(asset, at: index)
                }
                CLImagePickerTool.convertAssetArrToOriginImage(assetArr: selectAssets, scale: 0.1, successClouse: {[weak self] (image,assetItem) in
                    self?.images.remove(at: index)
                    self?.images.insert(image, at: index)
                    
                    }, failedClouse: { () in
                        
                })
                self?.applyPaymentProveView.images = (self?.images)!
            }
        }
    }
    
    @objc func commitButtonClicked() {
        //提交申请
        if applyPaymentProveView.textField.text == "" {
            MBProgressHUD.showInfo("请输入122平台登录密码")
            return
        }else if applyPaymentProveView.images.count <= 0 {
            MBProgressHUD.showInfo("请上传证明文件")
            return
        }
        MBProgressHUD.showWait("提交中，请稍后...")
        imagePaths.removeAll()
        for index in 0..<images.count {
            let image = images[index]
            let fileArray = [["img":image,"key":"file"]]
            NetWorkRequest(.uploadImage(type: "hotcity_claims", fileArray: fileArray), completion: { [weak self](result) -> (Void) in
                let code = result.object(forKey: "code") as! Int
                if code == 0 {
                    let imagePath = result.object(forKey: "data") as? String
                    print(imagePath ?? "")
                    if imagePath != nil {
                        self?.imagePaths.append(imagePath!)
                    }
                    if self?.imagePaths.count == (self?.images.count)! {
                        self?.commit()
                    }
                }else if code == 402 {
                    MBProgressHUD.hide()
                    UserDefaults.standard.removeObject(forKey: isLogin)
                    UserDefaults.standard.removeObject(forKey: loginInfo)
                    let loginVC = LoginViewController()
                    loginVC.reLoginDelegate = self
                    loginVC.isFirstLogin = false
                    self?.present(loginVC, animated: true, completion: nil)
                }
            }) { (error) -> (Void) in
                MBProgressHUD.hide()
                MBProgressHUD.showInfo("提交失败，请稍后重试")
            }
        }
    }
    
    func commit() {
        var params = [String : Any]()
        params["password"] = applyPaymentProveView.textField.text
        
        let filePath = imagePaths.joined(separator: ",")
        params["filePath"] = filePath
        
        let policyId = dicInfo?.object(forKey: "policyOrderId") as? Int
        params["policyOrderId"] = policyId
        
        NetWorkRequest(.applyPay(params: params), completion: { [weak self](result) -> (Void) in
            MBProgressHUD.hide()
            let code = result.object(forKey: "code") as! Int
            if code == 0 {
                MBProgressHUD.showSuccess("已提交")
            }else if code == 402 {
                MBProgressHUD.hide()
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
