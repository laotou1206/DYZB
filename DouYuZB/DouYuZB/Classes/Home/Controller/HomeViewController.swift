//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/12.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    //  MARK:- 懒加载 TitleView
    private lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        
        titleView.delegate = self
//        titleView.backgroundColor = UIColor.orange
        
        return titleView
    }()
    
    // MARK:- 懒加载 pageContentView
    private lazy var pageContentView : PageContentView = { [weak self] in
        
        //确定内容的 frame
        let contentH : CGFloat = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
        
        let contentFrame = CGRect (x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        //确定我们所有的子控制器
        var childViewControllers : [UIViewController] = [UIViewController]()
        childViewControllers.append(RecommendViewController())
        for _ in 0 ..< 3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childViewControllers.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childViewControllers: childViewControllers, parentViewController: self)
        contentView.delegate = self
        
        
        return contentView
    }()
    
    
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置UI
        setupUI()
        
    }
 
}

// MARK : - 设置UI界面
extension HomeViewController{
    private func setupUI(){
        
//         UIScrollView's contentInsetAdjustmentBehavior
        //不需要调整UIScrollView 的内边距
//        automaticallyAdjustsScrollViewInsets = false
    
        if #available(iOS 11.0, *) {
//            contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
       
        
        // 1.设置导航栏
        setupNavigationBar()
        
        //2.添加titleView
        self.view.addSubview(pageTitleView)
        
        //3.添加ContentView
        pageContentView.backgroundColor = UIColor.purple
        self.view.addSubview(pageContentView)
        
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


extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
    
    
}

extension HomeViewController : PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
