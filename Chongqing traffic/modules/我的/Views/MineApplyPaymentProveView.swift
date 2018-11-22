//
//  MineApplyPaymentProveView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/21.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

// 创建闭包
//添加照片
typealias AddImageButtonClick = () -> Void
//删除
typealias DeleteImageButtonClick = ((Int) -> Void)
//重选
typealias ReselecteImageButtonClick = ((Int) -> Void)

class MineApplyPaymentProveView: UIView {
    
    var addImageButtonClick : AddImageButtonClick?
    var deleteImageButtonClick : DeleteImageButtonClick?
    var reselecteImageButtonClick : ReselecteImageButtonClick?
    
    
    private lazy var textFieldBgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = AssistColor.cgColor
        return view
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = KUIFont14
        textField.textColor = MainTextColor
        textField.placeholder = "请输入122平台登录密码"
        textField.clearButtonMode = UITextField.ViewMode.always
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var textFieldTipLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont12
        label.textColor = MainYellowColor
        label.text = "该密码仅用于理赔使用，请放心填写。"
        return label
    }()
    
    lazy var proveTipLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = Main155Color
        label.text = "证明文件"
        return label
    }()
    
    lazy var imagesBgView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage.init(named: "icon_add_image"), for: .normal)
        button.backgroundColor = KUIColorLine
        button.addTarget(self, action: #selector(addImageCLicked), for: .touchUpInside)
        return button
    }()
    
    var imageWidth = (KScreenWidth - 40*2 - 12*2)/3.0
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func addImageCLicked() {
        guard let addImageButtonClick = addImageButtonClick else { return }
        addImageButtonClick()
    }
    
    /// 设置图片数组
    @objc var images = [UIImage]() {
        didSet{
            for view in self.imagesBgView.subviews {
                view.removeFromSuperview()
            }
            if images.count == 0{
                return
            }
            var currenImageView = UIImageView()
            for i in 0..<images.count {
                let imageView = UIImageView()
                imageView.image = images[i]
                imageView.clipsToBounds = true
                imageView.contentMode = UIView.ContentMode.scaleAspectFill
                imageView.isUserInteractionEnabled = true
                self.imagesBgView.addSubview(imageView)
                imageView.snp.makeConstraints { (make) in
                    if i == 0{
                        make.top.left.equalToSuperview()
                    }else {
                        if i == 3 {
                            make.left.equalToSuperview()
                            make.top.equalTo(currenImageView.snp.bottom).offset(12)
                        }else {
                            make.left.equalTo(currenImageView.snp.right).offset(12)
                            make.top.equalTo(currenImageView.snp.top)
                        }
                    }
                    make.width.height.equalTo(imageWidth)
                }
                
                let deleteBtn = UIButton()
                deleteBtn.tag = 100 + i
                deleteBtn.setBackgroundImage(UIImage.init(named: "btn_image_delete"), for: .normal)
                deleteBtn.addTarget(self, action: #selector(deleteImage(button:)), for: .touchUpInside)
                imageView.addSubview(deleteBtn)
                deleteBtn.snp.makeConstraints { (make) in
                    make.top.right.equalToSuperview()
                    make.width.height.equalTo(18)
                }
                
                let reSelectBtn = UIButton()
                reSelectBtn.tag = 1000 + i
                reSelectBtn.titleLabel?.font = KUIFont12
                reSelectBtn.setTitle("重新选择", for: .normal)
                reSelectBtn.setTitleColor(.white, for: .normal)
                reSelectBtn.backgroundColor = UIColor.init(white: 0, alpha: 0.4)
                reSelectBtn.addTarget(self, action: #selector(reSelectImage(button:)), for: .touchUpInside)
                imageView.addSubview(reSelectBtn)
                reSelectBtn.snp.makeConstraints { (make) in
                    make.left.right.bottom.equalToSuperview()
                    make.height.equalTo(20)
                }
                currenImageView = imageView
            }
            
            if images.count < 6 {
                self.imagesBgView.addSubview(addImageButton)
                self.addImageButton.snp.makeConstraints { (make) in
                    make.width.height.equalTo(imageWidth)
                    if images.count == 3 {
                        make.left.equalToSuperview()
                        make.top.equalTo(currenImageView.snp.bottom).offset(12)
                    }else {
                        make.left.equalTo(currenImageView.snp.right).offset(12)
                        make.top.equalTo(currenImageView.snp.top)
                    }
                }
            }
        }
    }
    
    @objc func deleteImage(button:UIButton) {
        guard let deleteImageButtonClick = deleteImageButtonClick else { return }
        deleteImageButtonClick(button.tag - 100)
    }
    
    @objc func reSelectImage(button:UIButton) {
        guard let reselecteImageButtonClick = reselecteImageButtonClick else { return }
        reselecteImageButtonClick(button.tag-1000)
    }
}

extension MineApplyPaymentProveView {
    func setUpUI() {
        self.addSubview(textFieldBgView)
        self.textFieldBgView.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(20)
            make.height.equalTo(40)
        }
        
        self.textFieldBgView.addSubview(textField)
        self.textField.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(-20)
        }
        self.addSubview(textFieldTipLabel)
        self.textFieldTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.textFieldBgView.snp.bottom).offset(6)
        }
        
        self.addSubview(proveTipLabel)
        self.proveTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.top.equalTo(self.textFieldTipLabel.snp.bottom).offset(20)
        }
        
        self.addSubview(imagesBgView)
        self.imagesBgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.proveTipLabel.snp.bottom).offset(8)
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.height.equalTo(imageWidth*2+12)
            make.bottom.equalToSuperview()
        }
        
        self.imagesBgView.addSubview(addImageButton)
        self.addImageButton.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.height.equalTo(imageWidth)
        }
    }
}
