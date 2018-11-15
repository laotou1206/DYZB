//
//  CycleModel.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/15.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    
    // 标题
    @objc var title : String = ""
    // 展示的图片
    @objc var pic_url : String = ""
    //主播信息对应的字典
    @objc var room : [String : Any]?{
        didSet{
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    //主播信息对应的对象
    var anchor : AnchorModel?
    
    // MARK:- 自定义构造函数
    init(dic : [String : Any]){
        super.init()
        setValuesForKeys(dic)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
