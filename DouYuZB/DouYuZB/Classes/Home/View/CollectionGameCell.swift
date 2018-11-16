//
//  CollectionGameCell.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/16.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    
    //MARK: 控件属性
    
    @IBOutlet weak var contentImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    // MARK:- 展示的数据
    var anchorGroup : AnchorGroup? {
        
        didSet{
          
            titleLabel.text = anchorGroup?.tag_name
            
            let imgUrl = URL(string: anchorGroup?.icon_url ?? "")
            
            contentImage.kf.setImage(with: imgUrl, placeholder: UIImage(named: "home_more_btn"))
        }
    }
    

}
