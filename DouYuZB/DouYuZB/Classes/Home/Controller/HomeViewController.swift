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
        
        // 设置标题栏左边的图标
//        let logoBtn = UIBarButtonItem(imageName: "logo", highImageName: "", size: CGSize.zero)
        
//        logoBtn.setImage(UIImage(named: "logo"), for: .normal)
//        logoBtn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        
        //设置标题栏右边的 item
        let size = CGSize(width: 40, height: 40)
        
        let historyBtn = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        
        let searchBtn = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        let qrcodeBtn = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyBtn,searchBtn,qrcodeBtn]
        
        
        
    }
}
