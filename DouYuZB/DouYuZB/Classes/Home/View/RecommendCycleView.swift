//
//  RecommendCycleView.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/14.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

private let kCycleCellID : String  = "kCycleCellID"

class RecommendCycleView: UIView {
    
    var cycleTimer : Timer?
    
    // MARK:- 定义轮播图数组
    var cycleModels : [CycleModel]?{
        
        //属性监听器
        didSet{
          
            //刷新collectionView
            collectionView.reloadData()
            
            //设置PageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //默认滚动到中间位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0), section: 0)
            
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //加入定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }

    // MARK:- 控件属性
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = .init(rawValue: 0)
        
        //注册Cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)

        
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
        //设置collectionView 的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
       
    }
}

//MARK:- 提供一个快速创建View的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//MARK:- 遵守UICollectionView 的数据源协议
extension RecommendCycleView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
       
        return cell
    }
    
    
    
    
}


//MARK:- UICollection的代理协议
extension RecommendCycleView : UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 获取滚动的偏移量 让偏移量多加 0.5
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //计算 pageControl 的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    //用户拖动的时候取消自动滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    //结束拖动 加入自动滚动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
}


// MARK:- 对定时器的操作方法
extension RecommendCycleView{
    
    ///创建定时器
    private func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    
    ///移除定时器
    private func removeCycleTimer(){
        //从运行循环中移除
        cycleTimer?.invalidate()
        
        cycleTimer = nil
    }
    
    
    @objc private func scrollToNext(){
        
        //获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        //滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
    
}
