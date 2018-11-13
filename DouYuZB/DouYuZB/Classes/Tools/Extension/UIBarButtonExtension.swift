//
//  UIBarButtonExtension.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/12.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    //类方法
//    class  func createItem(imageName : String , highImageName : String , size : CGSize)-> UIBarButtonItem {
//        let  btn = UIButton()
//
//        btn.setImage(UIImage(named: imageName), for: .normal)
//
//        btn.setImage(UIImage(named: highImageName), for: .highlighted)
//
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//
//        return UIBarButtonItem(customView: btn)
//
//    }

    // 便利的构造函数 1：convenience 开头 2：必须明确的调用一个已经设计好的构造函数
    public  convenience init(imageName : String , highImageName : String = "", size : CGSize = CGSize.zero) {
        
        //创建UIButton
        let  btn = UIButton()
        // 设置btn图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        //设置大小
        if size == CGSize.zero {
             //自适应图片大小
             btn.sizeToFit()
        }else{
             btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
       
        // 创建UIBarButtonItem
        self.init(customView: btn)
    }

}
