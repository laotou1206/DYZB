//
//  UIColorExtension.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/13.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(r : CGFloat ,g : CGFloat ,b : CGFloat  ) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
