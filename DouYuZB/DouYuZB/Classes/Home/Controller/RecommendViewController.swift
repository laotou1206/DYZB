//
//  RecommendViewController.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/13.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - kItemMargin * 3) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let kHeaderViewH : CGFloat = 50

private let kNormalCellID : String = "kNormalCellID"
private let kPrettyCellID : String = "kPrettyCellID"
private let kHeaderViewID : String = "kHeaderViewID"


class RecommendViewController: UIViewController {

    
    //MARK:- 懒加载 ViewMOdel
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
    private lazy var anchorGroups : [AnchorGroup] = [AnchorGroup] ()
    
    //MARK:- 懒加载 主页面的View
    private lazy var collectionView : UICollectionView = { [unowned self] in
        
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize (width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        
        //头部布局大小
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //layout 设置间距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //创建UICollectionview
        let collectionView = UICollectionView (frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        //ItemVIew
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        //普通的Item
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        //颜值的Item
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        //注册头部VIew
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    //MARK:- 懒加载轮播图
    private lazy var cycleView : RecommendCycleView = {
        
        let cycleView = RecommendCycleView.recommendCycleView()
        
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        
        return cycleView
    }()
    
    //MARK:- 懒加载游戏View
    private lazy var recommendGameView : RecommendGameView = {
        
        let recommendGameView = RecommendGameView.recommendGameView()
        
        recommendGameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return recommendGameView
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
        
        //发送网络请求
        loadData()
       
    }
    

  
}


// MARK- 发送网络请求
extension RecommendViewController{
    
    private func loadData(){
        
        //请求推荐数据
        recommendVM.requestData { (anchorGroups) in
            self.anchorGroups = anchorGroups
            self.collectionView.reloadData()
            
            //数据传递给gameView
            self.recommendGameView.groups = anchorGroups
           
        }
        
        recommendVM.requestcycleData { (cycleModels) in
            
            self.cycleView.cycleModels = cycleModels
        }
        
    }
}



// MARK:- 设置UI界面内容
extension RecommendViewController {
    private func setupUI(){
        
        //将UICollectionView 添加到控制器的View中
        self.view.addSubview(collectionView)
        
        //将CycleView 添加到UICollectionView 中
        collectionView.addSubview(cycleView)
        
        //将GameView 添加到 collectionView
        collectionView.addSubview(recommendGameView)
        
        //设置CollectionView 的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 遵守UICollectionView 数据源的协议
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //一共有多少组数据结构
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.anchorGroups.count
    }
    
    //每组里面有多少数据
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = self.anchorGroups[section]
        return group.anchors.count
    }
    
    //列表的内容布局
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //取出数据
        let group = self.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        //获取 Cell  在这里判断获取那个Item
        var cell : CollectionBaseCell!
        
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as? CollectionBaseCell
          
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as? CollectionBaseCell
        
        }
        
        cell.anchor = anchor
        
        return cell

    }
    
    
    // 列表头部布局
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 取出数据
        headerView.group = self.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    
    // 设置列表布局的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
    
}

