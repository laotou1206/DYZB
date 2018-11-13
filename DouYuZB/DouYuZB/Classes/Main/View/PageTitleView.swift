//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/13.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    
    private var titles : [String]

    //MARK:- 自定义构造函数
    init(frame: CGRect , titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
