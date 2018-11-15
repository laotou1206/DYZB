//
//  CollectionCycleCell.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/15.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    
    //MARK:- 控件属性
    
    @IBOutlet weak var contentImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel : CycleModel?{
        
        didSet{
            
            titleLabel.text = cycleModel?.title
            
            let imgUrl = URL(string: (cycleModel?.pic_url)!)
            
            contentImage.kf.setImage(with: imgUrl)
            
        }
    }
    
    

}
