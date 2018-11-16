//
//  RecommendGameView.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/16.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {

    //MARK:- 控件属性
    
    @IBOutlet weak var gameCollectionView: UICollectionView!
    
    //MARK:- 展示的数据
    var groups : [AnchorGroup]?{
        
        //数据改变的监听器
        didSet{
            //移除前两种数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            //添加更多数据
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            //刷新界面
            gameCollectionView.reloadData()
        }
        
    }
    
    
    //MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //让控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        
        //注册Cell
        gameCollectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
       
        //添加内边距
        gameCollectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }

}

extension RecommendGameView{
    
    class func recommendGameView() -> RecommendGameView{
        
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}


// MARK:- 设置数据源
extension RecommendGameView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.anchorGroup  = groups?[indexPath.item]
        
        
        return cell
    }
    
    
}
