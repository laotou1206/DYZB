//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/12.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置UI
        setupUI()
        
    }
 
}

// MARK : - 设置UI界面
extension HomeViewController{
    private func setupUI(){
        
        // 1.设置导航栏
        setupNavigationBar()
        
    }
    
    //导航栏
    private func setupNavigationBar(){
        
        let logoBtn = UIButton()
        
        logoBtn.setImage(UIImage(named: "logo"), for: .normal)
        
        logoBtn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoBtn)
    }
}
