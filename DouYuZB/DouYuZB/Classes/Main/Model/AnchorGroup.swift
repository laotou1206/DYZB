//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/15.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    /// 组中对应的房间信息
    @objc var room_list : [[String : Any]]? {
        //属性监听器
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    /// 组中对应的标题
    @objc var tag_name : String = ""
    
    /// 列表组显示的图标
    @objc var icon_image : String = "home_header_normal"
    
    // 组的图标
    @objc var icon_url : String = ""
    
    ///定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dict : [String : Any]){
        super.init()
        
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
  
}
