//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/15.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {

    ///房间ID
    @objc var room_id : Int = 0
    ///房间对应的图片
    @objc var vertical_src : String = ""
    ///判断是电脑直播还是手机直播 0:电脑直播  1:手机直播
    @objc var isVertical : Int = 0
    ///房间名称
    @objc var room_name : String = ""
    ///主播昵称
    @objc var nickname : String = ""
    ///观看人数
    @objc var online : Int = 0
    ///所在城市
    @objc var anchor_city = ""
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    
    }
}
