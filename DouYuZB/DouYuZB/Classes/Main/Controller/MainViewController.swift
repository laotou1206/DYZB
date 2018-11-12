//
//  MainViewController.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/12.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加页面 按顺序添加 这个方法为了兼容 iOS8 及以下版本
        
        addChildViewController(storyName: "Home")
        
        addChildViewController(storyName: "Follow")
        
        addChildViewController(storyName: "Live")
        
        addChildViewController(storyName: "Profile")
        

    }
    
    private func addChildViewController(storyName : String){
        
        // 1.通过StoryBoard 获取控制器
        if let childViewController = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController(){
            
            // 2.将childViweController 作为子控制器
            addChild(childViewController)
            
        }
        
    }
    

}
