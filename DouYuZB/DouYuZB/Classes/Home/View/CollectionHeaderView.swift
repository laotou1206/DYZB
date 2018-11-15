//
//  CollectionHeaderView.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/13.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    //MARK:- 控件的属性
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_image ?? "home_header_normal")
        }
    }
}
