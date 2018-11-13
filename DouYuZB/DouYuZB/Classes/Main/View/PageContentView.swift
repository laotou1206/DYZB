//
//  PageContentView.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/13.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

private let ContentCellID : String = "ContentCellID"

protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView , progress : CGFloat ,sourceIndex : Int ,targetIndex : Int)
}

class PageContentView: UIView {
    
    private var childViewControllers : [UIViewController]

    private weak var parentViewController : UIViewController?
    
    private var startOffsetX : CGFloat = 0
    
    private var isForbidScrollDelegate = false
    
    weak var delegate : PageContentViewDelegate?
    
    private lazy var collectionView : UICollectionView = { [weak self] in
        
        //创建Layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //创建UICollectionVIew
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID )
        
        return collectionView
        
    }()
    
    
    // MARK:- 自定义构造函数
    init(frame: CGRect , childViewControllers :[UIViewController] , parentViewController : UIViewController?) {
        
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        
        super.init(frame: frame)

        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//  MARK:-设置UI界面
extension PageContentView {
    private func setupUI(){
        
        //将所有子控制器添加到 父控制器中
        for childViewController in childViewControllers {
            parentViewController?.addChild(childViewController)
        }
        
        //添加UICollectionview 用于在Cell 中存放控制器的View
        collectionView.frame = bounds
        addSubview(collectionView)
    }
}

//MARK:- 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //创建 Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        //给Cell 设置内容
        let childViewController = childViewControllers[indexPath.item]
        
        childViewController.view.frame = cell.contentView.bounds
        
        cell.contentView.addSubview(childViewController.view)
        
        return cell
    
    }
    
    
}

// MARK:- 对外面暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        
        //记录需要禁止执行的代理方法
        isForbidScrollDelegate = true
        
        // 滑动到正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}

extension PageContentView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //如果是点击事件 禁止颜色渐变
        if isForbidScrollDelegate { return }
        
        // 滚动的进度  原来的sourceIndex  目标的targetIndex
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollviewW = scrollView.bounds.width
        if  currentOffsetX > startOffsetX {
            //左滑  计算progress
            progress = currentOffsetX / scrollviewW - floor(currentOffsetX / scrollviewW)
            //计算 sourceIndex
            sourceIndex = Int( currentOffsetX / scrollviewW)
            //计算 targetIndex
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childViewControllers.count{
                targetIndex = childViewControllers.count - 1
            }
            
            // 如果完全滑过去
            if currentOffsetX - startOffsetX == scrollviewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{
            //右滑 计算progress
             progress = 1 - (currentOffsetX / scrollviewW - floor(currentOffsetX / scrollviewW))
            
            //计算 targetIndex
            targetIndex = Int( currentOffsetX / scrollviewW)
            
            //计算 sourceIndex
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childViewControllers.count{
                sourceIndex = childViewControllers.count - 1
            }
        }
        
        //将progress、sourceIndex、targetIndex 传递给titleView
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    //开始滑动 获取偏移量
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //开始执行滑动代理的方法
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
}


