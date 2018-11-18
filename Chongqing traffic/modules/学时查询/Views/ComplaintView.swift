//
//  ComplaintView.swift
//  Chongqing traffic
//
//  Created by 朱兴乐 on 2018/11/17.
//  Copyright © 2018年 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

// 创建闭包
//选择投诉对象
typealias ComplaintSelectObjectClick = () -> (Void)
//一键投诉
typealias ComplaintClick = () -> (Void)

class ComplaintView: UIView {
    
    var complaintSelectObjectClick : ComplaintSelectObjectClick?
    var complaintClick : ComplaintClick?
    
    
    private lazy var selectObjectbgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = KUIColorBG
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = 4
        bgView.isUserInteractionEnabled = true
        bgView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(selectComplaintObject)))
        return bgView
    }()
    
    lazy var imageBgView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var selectObjectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "icon_login_drivingType")
        return imageView
    }()
    
    lazy var selectObjectLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont14
        label.textColor = Main155Color
        label.text = "请选择投诉对象"
//        label.isUserInteractionEnabled = true
//        label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(selectComplaintObject)))
        return label
    }()
    
    lazy var textBgView: UIView = {
        let view = UIView()
        view.layer.borderColor = KUIColorLine.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        return view
    }()
    
    lazy var textView:KMPlaceholderTextView  = {
        let textView = KMPlaceholderTextView(frame: CGRect.zero)
        textView.delegate = self
        textView.font = KUIFont14
        textView.textColor = .black
        textView.placeholder = "请输入您的投诉详情..."
        return textView
    }()
    
    private lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.font = KUIFont12
        label.textColor = Main155Color
        label.text = "至少输入10个字"
        return label
    }()
    
    lazy var complaintButton: BaseButton = {
        let button = BaseButton()
        button.backgroundColor = MainYellowColor
        button.titleLabel?.font = KUIFont12
        button.setTitle("一键投诉", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(complaint), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    ///选择投诉对象
    @objc func selectComplaintObject() {
        guard let complaintSelectObjectClick = complaintSelectObjectClick else { return }
        complaintSelectObjectClick()
    }
    
    ///一键投诉
    @objc func complaint() {
        guard let complaintClick = complaintClick else { return }
        complaintClick()
    }
}

extension ComplaintView {
    func setUpUI() {
        self.addSubview(selectObjectbgView)
        self.selectObjectbgView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(22)
            make.height.equalTo(40)
        }
        
        self.selectObjectbgView.addSubview(imageBgView)
        self.imageBgView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(40)
        }
        
        self.imageBgView.addSubview(selectObjectImageView)
        self.selectObjectImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.selectObjectbgView.addSubview(selectObjectLabel)
        self.selectObjectLabel.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(40)
        }
        
        self.addSubview(textBgView)
        self.textBgView.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(self.selectObjectbgView.snp.bottom).offset(20)
            make.height.greaterThanOrEqualTo(140)
            make.height.lessThanOrEqualTo(KScreenHeigth - navigationBarHeight - tabBarHeight - 180)
        }
        
        self.textBgView.addSubview(textView)
        self.textView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalToSuperview()
            make.bottom.equalTo(-40)
        }
        
        self.textBgView.addSubview(tipLabel)
        self.tipLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.bottom.equalTo(-12)
        }
        
        self.addSubview(complaintButton)
        self.complaintButton.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(self.textBgView.snp.bottom).offset(20)
            make.width.equalTo(60)
            make.height.equalTo(24)
        }
    }
}

extension ComplaintView : UITextViewDelegate {
    func textViewDidChange(_ textView:UITextView) {
        let maxHeight = KScreenHeigth - navigationBarHeight - tabBarHeight - 220
        //获取frame值
        let frame = textView.frame
        //定义一个constrainSize值用于计算textview的高度
        let constrainSize=CGSize(width:frame.size.width,height:CGFloat(MAXFLOAT))
        //获取textview的真实高度
        var size = textView.sizeThatFits(constrainSize)
        //如果textview的高度大于最大高度高度就为最大高度并可以滚动，否则不能滚动
        if size.height>=maxHeight{
            size.height=maxHeight
            textView.isScrollEnabled=true
        }else{
            textView.isScrollEnabled=false
        }
        //重新设置textview的高度
        textView.frame.size.height=size.height
        
        //获得已输出字数与正输入字母数
        let selectRange = textView.markedTextRange
        //获取高亮部分 － 如果有联想词则解包成功
        if let selectRange = selectRange {
            let position =  textView.position(from: (selectRange.start), offset: 0)
            if (position != nil) {
                return
            }
        }
        
        let textContent = textView.text
        let textNum = textContent?.count
        //截取200个字
        if textNum! > 100 {
            let index = textContent?.index((textContent?.startIndex)!, offsetBy: 100)
            let str = textContent?.prefix(upTo: index!)
            textView.text = String(str ?? "")
        }
        
        if textView.text.count > 0 {
            self.tipLabel.text = "\(textView.text.count)/100"
        }else {
            self.tipLabel.text = "至少输入10个字"
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //获得已输出字数与正输入字母数
        let selectRange = textView.markedTextRange
        //获取高亮部分 － 如果有联想词则解包成功
        if let selectRange = selectRange {
            let position =  textView.position(from: (selectRange.start), offset: 0)
            if (position != nil) {
                return true
            }
        }

        return textView.text.count + (text.count - range.length) <= 100
    }
}
