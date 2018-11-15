//
//  NSDateExtension.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/15.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import Foundation

extension NSDate {
    
    class func getCurrentTime() -> String {
        
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
