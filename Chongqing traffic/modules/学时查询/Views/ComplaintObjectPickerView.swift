//
//  ComplaintObjectPickerView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/24.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class ComplaintObjectPickerView: UIView {

    //MARK: -内部参数
    // 选中
    var selectedObject: String?
    // 记录选中的位置
    var selectedIndex: Int = 0
    // 投诉对象数组
    var dataSource = [String]()
    
    //MARK: -懒加载
    /// 创建城市选择器
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRect(x: 0, y:
            60, width:KScreenWidth , height: KScreenHeigth*0.4))
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.white
        return pickerView
    }()
    
    /// 创建容器
    lazy var containView: UIView = {
        let containView = UIView(frame: CGRect(x: 0, y: KScreenHeigth, width:KScreenWidth , height: KScreenHeigth*0.4+60))
        containView.backgroundColor = UIColor.gray
        return containView
    }()
    
    /// 创建容器中的titleToolBar
    lazy var titleToolBar: UIView = {
        let titleToolBar = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 60))
        titleToolBar.backgroundColor = UIColor.white
        return titleToolBar
    }()
    
    ///创建分割线
    lazy var lineView: UIView = {
        let lineView = UIView(frame: CGRect(x: 0, y: 59.5, width: KScreenWidth, height: 0.5))
        lineView.backgroundColor = KUIColorLine
        return lineView
    }()
    
    /// 创建确定按钮
    lazy var sureButton: UIButton = {
        let sureButton = UIButton(frame: CGRect(x: KScreenWidth - 80, y: 0, width: 80, height: 60))
        //        let sureButton = UIButton()
        sureButton.setTitle("确定", for: .normal)
        sureButton.addTarget(self, action: #selector(addressButtonOnclik), for: .touchUpInside)
        sureButton.setTitleColor(MainTextColor, for: .normal)
        sureButton.titleLabel?.font = KUIFont18
        sureButton.tag = 1
        return sureButton
    }()
    
    /// 创建取消按钮
    lazy var cancleButton: UIButton = {
        let cancleButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 60))
        //        let cancleButton = UIButton()
        cancleButton.setTitle("取消", for: .normal)
        cancleButton.addTarget(self, action: #selector(addressButtonOnclik), for: .touchUpInside)
        cancleButton.setTitleColor(MainTextColor, for: .normal)
        cancleButton.titleLabel?.font = KUIFont18
        return cancleButton
    }()
    
    // 回调函数
    // 区域block
    var selectedComplaintObjectBlock:((_ object:String)->())?
    
    public var pickerLabelFont: UIFont?{
        willSet{
            pickerView.reloadAllComponents()
        }
    }
    /// pickerView的字体颜色
    public var pickerLabelTextCoclor: UIColor?{
        willSet{
            pickerView.reloadAllComponents()
        }
    }
    
    //MARK: - 系统方法
    /// 系统初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 设置界面
        setup()
        
        //设置数据
        //        kl_layoutSubviws()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -界面初始化
    /// 初始化界面
    func setup(){
        self.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeigth)
        // 添加容器
        addSubview(containView)
        // 添加titleToolBar
        containView.addSubview(titleToolBar)
        // 添加pickerView
        containView.addSubview(pickerView)
        // 添加确定按钮
        titleToolBar.addSubview(sureButton)
        // 添加取消按钮
        titleToolBar.addSubview(cancleButton)
        titleToolBar.addSubview(lineView)
    }
    
    //MARK: -获取数据
    func getData(){
        self.dataSource = ["驾校","教练"]
        // 如果没有传入默认值默认选中第一个
        if selectedObject == nil {
            selectedObject = self.dataSource.first
        }
        
        for i in (0 ... self.dataSource.count - 1) {
            let objectStr = self.dataSource[i]
            if objectStr == selectedObject {
                selectedIndex = i
            }
        }
        //滚动到固定的行
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
    }
    
    @objc func addressButtonOnclik(currentButton: UIButton){
        //隐藏界面
        hideView()
        if currentButton.tag == 1{
            if (selectedComplaintObjectBlock != nil) {
                selectedComplaintObjectBlock?(selectedObject!)
            }
        }
    }
    
    /// 显示view
    func showView() {
        UIApplication.shared.keyWindow?.addSubview(self)
        backgroundColor = UIColor.clear
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = UIColor().hexStringToColor(hexString: "0x000000", alpha: 0.3)
            self.containView.kl_bottom = KScreenHeigth
        }
    }
    
    /// 隐藏View
    func hideView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = UIColor.clear
            self.containView.kl_y =  KScreenHeigth
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
    
    //MARK: - 初始化
    /// 显示培训车型
    /// - Parameter addressBlock: 回调返回培训车型
    public func pickerViewWithComplaintObjectBlock(complaintObjectBlock:((String)->())?){
        selectedComplaintObjectBlock = complaintObjectBlock
        // 设置数据
        getData()
        showView()
    }
}

//MARK: -UIPickerViewDataSource, UIPickerViewDelegate 方法
extension ComplaintObjectPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dataSource.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = view as? UILabel
        if label == nil {
            label = UILabel(frame: CGRect(x: 0, y: 0, width: kl_width/3, height: 30))
            label?.adjustsFontSizeToFitWidth = true
            label?.textAlignment = .center
            label?.textColor = pickerLabelTextCoclor == nil ? UIColor().hexStringToColor(hexString: "0x666666", alpha: 1): pickerLabelTextCoclor
            label?.font = pickerLabelFont == nil ? UIFont.systemFont(ofSize: 17) : pickerLabelFont
        }
        label?.text =  self.dataSource[row]
        return label!
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
        selectedObject = dataSource[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
}
