//
//  ZLPageTitleView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/16.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

protocol ZLPageTitleViewDelegate : class {
    func pageView(pageView:ZLPageTitleView,selectIndex:Int)
    
}

class ZLPageTitleView: UIView {
    weak var delegate:ZLPageTitleViewDelegate?
    
    fileprivate var style:ZLPageStyle
    
    fileprivate var currentView:UIView
    
    var titles:[String]
    var titleLabels:[UILabel] = [UILabel]()
    lazy var scrollView:UIScrollView = {
        let scroll = UIScrollView(frame: self.bounds)
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    lazy var lineView:UIView = {
        let line = UIView()
        line.backgroundColor = self.style.titleBottomLineColor
        line.frame.size.height = 2
        line.frame.origin.y = self.bounds.size.height - line.frame.size.height
        return line
    }()
    
    lazy var bottomLineView:UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = self.style.bottomLineColor
        bottomLine.frame = CGRect.init(x: 0, y: self.bounds.size.height - 1, width: self.bounds.size.width, height: 1)
        return bottomLine
    }()
    
    fileprivate var currentIndex:Int = 0
    
    init(frame:CGRect,titles:[String],style:ZLPageStyle = ZLPageStyle()) {
        self.titles = titles
        self.style = style
        currentView = UIView()
        currentView.backgroundColor = UIColor.init(r: 173, g: 215, b: 106)
        currentView.layer.masksToBounds = true
        currentView.layer.cornerRadius = 3.5
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZLPageTitleView{
    fileprivate func setupUI(){
        //设置scrollView
        addSubview(scrollView)
        //初始化lineView
        scrollView.addSubview(lineView)
        //初始化title
        setupLabels()
    }
    
    // MARK: 初始化Item
    private func setupLabels(){
        var x:CGFloat = 0
        let y:CGFloat = 0
        var textWidth:CGFloat = 0
        var labelWidth:CGFloat = 0
        let height:CGFloat = self.style.labelHeight
        let margin:CGFloat = self.style.labelMargin
        let normalWidth:CGFloat = 60
        var preLabel:UILabel = UILabel()
        for (i,title) in titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textColor = style.normalColor
            titleLabel.font = UIFont.systemFont(ofSize: style.labelFont)
            titleLabel.tag = i
            titleLabel.textAlignment = .center
            titleLabel.isUserInteractionEnabled = true
            titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemClick(_:))))
            //设置frame
            textWidth = widthForContent(titleLabel)
            if style.labelLayout == .divide{
                labelWidth = bounds.size.width/CGFloat(titles.count)
            }else if style.labelLayout == .center{
                labelWidth = normalWidth
            }else{
                labelWidth = textWidth
            }
            
            if i == 0{
                if style.labelLayout == .scroll {
                    x = margin*0.5
                    
                }else if style.labelLayout == .divide{
                    x = 0
                }
                else{  //设置居中情况下x
                    x = (bounds.size.width - textWidth*CGFloat(titles.count))/CGFloat(2)
                }
                
                lineView.frame.origin.x = style.isBottomAlginLabel ? x : (labelWidth - textWidth)/2.0
                lineView.frame.size.width = style.isBottomAlginLabel ? labelWidth : textWidth
                titleLabel.textColor = style.selectColor
                
            }else{
                if style.labelLayout == .scroll {
                    x = preLabel.frame.maxX + margin
                }else {
                    x = preLabel.frame.maxX
                }
            }
            titleLabel.frame = CGRect(x: x, y: y, width: labelWidth, height: height)
            
            //添加到视图中
            scrollView.addSubview(titleLabel)
            titleLabels.append(titleLabel)
            preLabel = titleLabel
        }
        
        //设置scrollView的ContentSize
        bottomLineView.frame.size.width = preLabel.frame.maxX+margin*0.5
        if self.style.isShowBottomLine {
            scrollView.addSubview(bottomLineView)
        }
        scrollView.contentSize = CGSize(width: preLabel.frame.maxX+margin*0.5, height: style.labelHeight)
        scrollView.bringSubviewToFront(lineView)
    }
    
    fileprivate func widthForContent(_ label:UILabel) -> CGFloat{
        return ((label.text! as NSString).boundingRect(with: CGSize(width : CGFloat.greatestFiniteMagnitude, height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:label.font], context: nil)).width
    }
    
}

extension ZLPageTitleView{
    
    private func ajustViewPostion(_ selectLabel:UILabel){
        let preLabel = titleLabels[currentIndex]
        currentIndex = selectLabel.tag
        
        preLabel.textColor = style.normalColor
        selectLabel.textColor = style.selectColor
        
        //设置lineView的位置
        //计算textWidth
        UIView .animate(withDuration: 0.25) {
            if self.style.isBottomAlginLabel{
                self.lineView.frame.origin.x = selectLabel.frame.origin.x
            }else{
                //使用center.x会有偏差，采用frame.x
                self.lineView.frame.origin.x = (selectLabel.frame.size.width - self.widthForContent(selectLabel))/CGFloat(2) + selectLabel.frame.minX
            }
            self.lineView.frame.size.width = self.style.isBottomAlginLabel ? selectLabel.frame.size.width : self.widthForContent(selectLabel)
        }
        
        if style.labelLayout == .scroll {
            
            if scrollView.contentSize.width <= bounds.size.width {
                return
            }
            //中间offset
            var offsetX = selectLabel.center.x - bounds.size.width*0.5
            //最大offset
            let maxOffset = scrollView.contentSize.width - bounds.width
            //最小offset
            if offsetX <= 0{
                offsetX = 0
            }else if offsetX >= maxOffset{
                offsetX = maxOffset
            }
            scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        }
    }
    
    @objc fileprivate func itemClick(_ tap:UITapGestureRecognizer){
        //获取目标item
        let selectLabel = tap.view as! UILabel
        //调整位置
        ajustViewPostion(selectLabel)
        //通知外部选中状态
        delegate?.pageView(pageView: self, selectIndex: currentIndex)
    }
    
    // MARK: 更新label 更新lineView
    
    public func pageScrollView(sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
        if sourceIndex >= titleLabels.count || sourceIndex < 0 {
            return
        }
        if targetIndex >= titleLabels.count || targetIndex < 0 {
            return
        }
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let selectRGB = getGRBValue(style.selectColor)
        let normalRGB = getGRBValue(style.normalColor)
        let deltaRGB = (selectRGB.0 - normalRGB.0, selectRGB.1 - normalRGB.1, selectRGB.2 - normalRGB.2)
        sourceLabel.textColor = UIColor(r: selectRGB.0 - progress * deltaRGB.0, g: selectRGB.1 - progress * deltaRGB.1, b: selectRGB.2 - progress * deltaRGB.2)
        targetLabel.textColor = UIColor(r: normalRGB.0 + progress * deltaRGB.0, g: normalRGB.1 + progress * deltaRGB.1, b: normalRGB.2 + progress * deltaRGB.2)
        
        if style.isTitleScaleEnabled {
            let deltaScale = style.titleMaximumScaleFactor - 1.0
            sourceLabel.transform = CGAffineTransform(scaleX: style.titleMaximumScaleFactor - progress * deltaScale, y: style.titleMaximumScaleFactor - progress * deltaScale)
            targetLabel.transform = CGAffineTransform(scaleX: 1.0 + progress * deltaScale, y: 1.0 + progress * deltaScale)
        }
        
        if style.isShowTitleBottomLine {
            let deltaX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
            let deltaW = targetLabel.frame.width - sourceLabel.frame.width
            
            lineView.center.x = sourceLabel.center.x + progress * deltaX
            //            lineView.frame.size.width = sourceLabel.frame.width + progress * deltaW
            lineView.frame.size.width = (style.isBottomAlginLabel ? sourceLabel.frame.size.width : widthForContent(sourceLabel)) + deltaW*progress
        }
    }
    
    func pageViewScrollEnd(pageIndex:Int){
        
        //拿到选中的label
        let selectLabel = titleLabels[pageIndex]
        ajustViewPostion(selectLabel)
    }
    
    ///初始化的时候当前部分添加标识
    func currentPart(currentIndex:Int) {
        let selectLabel = titleLabels[currentIndex]
        
        currentView.removeFromSuperview()
        currentView.frame = CGRect.init(x: (selectLabel.frame.size.width - lineView.frame.size.width)/2.0 - 10, y: (selectLabel.frame.size.height - 7)/2.0, width: 7, height: 7)
        selectLabel.addSubview(self.currentView)
    }
    
    private func getGRBValue(_ color : UIColor) -> (CGFloat, CGFloat, CGFloat) {
        guard  let components = color.cgColor.components else {
            fatalError("文字颜色请按照RGB方式设置")
        }
        return (components[0] * 255, components[1] * 255, components[2] * 255)
    }
}
