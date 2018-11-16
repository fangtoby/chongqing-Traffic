//
//  ZLPageView.swift
//  Chongqing traffic
//
//  Created by Zhu Xingle on 2018/11/16.
//  Copyright © 2018 Beijing Guo Jiao Yun Net Technology Co., Ltd. All rights reserved.
//

import UIKit

class ZLPageView: UIView {

    fileprivate var titles:[String]
    fileprivate var controllers:[UIViewController]
    fileprivate var parentVc:UIViewController
    fileprivate var style:ZLPageStyle
    
    fileprivate var startOffsetX:CGFloat = 0  //按下瞬间的offsetX
    fileprivate var isForbideScroll:Bool = false
    fileprivate var currentIndex:Int = 0
    
    fileprivate lazy var titleView: ZLPageTitleView = {
        let titleView:ZLPageTitleView = ZLPageTitleView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.style.labelHeight), titles: self.titles, style: self.style)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.bounds.size.width, height: self.bounds.size.height - self.style.labelHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collection:UICollectionView = UICollectionView(frame: CGRect(x: 0, y: self.style.labelHeight, width: self.bounds.size.width, height: self.bounds.size.height - self.style.labelHeight), collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collection.scrollsToTop = false
        collection.isPagingEnabled = true
        collection.bounces = false
        collection.showsHorizontalScrollIndicator = false
        return collection
        
    }()
    
    init(frame:CGRect,titles:[String],childControllers:[UIViewController],parentController:UIViewController,style:ZLPageStyle = ZLPageStyle()) {
        
        //初始化参数
        self.titles = titles
        self.controllers = childControllers
        self.style = style
        self.parentVc = parentController
        
        super.init(frame: frame)
        
        //UI
        setupUI()
    }
    
    public func currentIndex(index:Int) {
        titleView.pageViewScrollEnd(pageIndex: index)
        let indexPath = IndexPath(row: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZLPageView {
    
    fileprivate func setupUI(){
        
        //设置titleView
        addSubview(titleView)
        
        //设置子控制器
        for vc  in controllers {
            parentVc.addChild(vc)
        }
        //设置contentView
        addSubview(collectionView)
        
    }
}

extension ZLPageView:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        let vc = controllers[indexPath.row]
        vc.view.frame = cell.contentView.bounds
        cell.contentView .addSubview(vc.view)
        
        return cell
    }
}

extension ZLPageView:UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
        isForbideScroll = false
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if startOffsetX == scrollView.contentOffset.x { return }
        if isForbideScroll { return}
        
        var progress: CGFloat = 0
        var targetIndex = 0
        var sourceIndex = 0
        
        progress = scrollView.contentOffset.x.truncatingRemainder(dividingBy: scrollView.bounds.width) / scrollView.bounds.width
        if progress == 0 {
            return
        }
        
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        if collectionView.contentOffset.x > startOffsetX { // 左滑动
            sourceIndex = index
            targetIndex = index + 1
            if targetIndex > controllers.count - 1 {
                return
            }
        } else {
            sourceIndex = index + 1
            targetIndex = index
            progress = 1 - progress
            if targetIndex < 0 {
                return
            }
        }
        
        if progress > 0.998 {
            progress = 1
        }
        titleView.pageScrollView(sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        //拖动结束 计算index
        var index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        let width = scrollView.bounds.size.width
        let count = Int(scrollView.contentSize.width/width)
        if index < 0{
            index = 0
        }
        if index > count - 1 {
            index = count - 1
        }
        //设置viewFrame
        currentIndex = index
        //让pageView滚动起来
        titleView.pageViewScrollEnd(pageIndex: index)
    }
}

extension ZLPageView : ZLPageTitleViewDelegate{
    
    func pageView(pageView: ZLPageTitleView, selectIndex: Int) {
        isForbideScroll = true
        //设置view frame
        currentIndex = selectIndex
        //让collectionView滚动
        let indexPath = IndexPath(row: selectIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}
