//
//  CollectionNormalCell.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/14.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    
    //MARK:- 控件的属性
    
    @IBOutlet weak var roomNameLabel: UILabel!


    override var anchor : AnchorModel?{

        didSet{

            super.anchor = anchor

            roomNameLabel.text = anchor?.room_name

        }
    }
    

}
