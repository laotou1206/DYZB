//
//  CollectionBaseCell.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/15.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    //MARK:- 控件属性
    @IBOutlet weak var contentImage: UIImageView!
    
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    @IBOutlet weak var nickNameLabel: UILabel!

    
    var anchor : AnchorModel?{

        didSet{
            guard let anchor = anchor else { return }

            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }

            onlineBtn.setTitle(onlineStr, for: .normal)

            nickNameLabel.text = anchor.nickname


            //显示图片
            let imgUrl = URL(string: anchor.vertical_src)
            contentImage.kf.setImage(with: imgUrl)
        }
    }
    
}
