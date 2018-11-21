//
//  MineApplyPaymentViewController.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/20.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class MineApplyPaymentViewController: BaseViewController {
    
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

        let image1 = UIImage.init(named: "pic1.jpeg")
        let image2 = UIImage.init(named: "pic2.jpeg")
        let image3 = UIImage.init(named: "pic3.jpeg")
        let image4 = UIImage.init(named: "pic1.jpeg")
        let image5 = UIImage.init(named: "pic2.jpeg")
        let image6 = UIImage.init(named: "pic3.jpeg")
        
        var images:[UIImage] = [image1!,image2!,image3!,image4!,image5!]
        
        self.applyPaymentProveView.setImagesView(images: images)
        
        self.applyPaymentProveView.addImageButtonClick = { [weak self] in
            images.append(image6!)
            self?.applyPaymentProveView.setImagesView(images: images)
        }
        
        self.applyPaymentProveView.deleteImageButtonClick = { [weak self] (index) in
            images.remove(at: index)
            self?.applyPaymentProveView.setImagesView(images: images)
        }
    }
    
    @objc func commitButtonClicked() {
        //申请理赔
        let applyPaymentVC = MineApplyPaymentViewController()
        self.navigationController?.pushViewController(applyPaymentVC, animated: true)
    }
}
