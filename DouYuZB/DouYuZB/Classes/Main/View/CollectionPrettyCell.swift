//
//  CollectionPrettyCell.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/14.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {
    
    //MARK:- 控件属性
  
    
    @IBOutlet weak var cityBtn: UIButton!
    

    
   override var anchor : AnchorModel?{
    
        didSet{
            super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }
    }

 

}
