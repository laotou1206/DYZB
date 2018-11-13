//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/13.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

// MARK:- 定义协议
protocol  PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView , selectedIndex index : Int) ;
}

// 定义常量
private let kScrollLineH : CGFloat = 2

//标题栏颜色 用元组定义
private let kNormalColor : (r : CGFloat,g : CGFloat,b : CGFloat) = (85,85,85)
private let kSelectColor : (r : CGFloat,g : CGFloat,b : CGFloat) = (255,128,0)

class PageTitleView: UIView {
    
    private var currentIndex : Int = 0
    
    private var titles : [String]
    
    
    
    weak var delegate : PageTitleViewDelegate?
    
    //label 的数组
    private lazy var titleLabels : [UILabel] = [UILabel]()

    // MARK:- 懒加载一个 属性  ScrollView
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        //取消水平的线
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.scrollsToTop = false
        
        scrollView.bounces = false
        
        return scrollView
    }()
    
    // MARK:- 懒加载 滚动的线 scrollLine
    private lazy var scrollLine : UIView = {
       
        let scrollLine = UIView()
        
        return scrollLine
        
    }()
    
    
    //MARK:- 自定义构造函数
    init(frame: CGRect , titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- 设置UI 界面
extension PageTitleView {
    
    private func setupUI(){
        
      
        //添加UIScrollView
        self.addSubview(scrollView)
        
        scrollView.frame = bounds
        
        //添加Label
        setupTitleLabels()
        
        //设置底线跟 滚动的滑块
        setupBottomLineAndScrollLine()
        
        
    }
    
    //添加 Title 对应的 Label
    private func setupTitleLabels (){
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
       
        let labelY : CGFloat = 0
        
        for (index , title) in titles.enumerated() {
        
            //创建UILabel
            let label = UILabel()
            
            //设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.init(r: kNormalColor.r, g: kNormalColor.g, b: kNormalColor.b)
            label.textAlignment = .center
            
            //设置Label 的 frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 将Label 添加到 ScrollView
            
            scrollView.addSubview(label)
            
            titleLabels.append(label)
        
            
            //给Label 添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            
            label.addGestureRecognizer(tapGes)
        }
        
        
    }
    
    private func setupBottomLineAndScrollLine(){
        
        //添加底线
        let bottomLine = UIView()
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        self.addSubview(bottomLine)
        
        //添加滚动的那条线
        //获取第一个Label
        guard let firstLabel = titleLabels.first else{ return }
        firstLabel.textColor = UIColor.init(r: kSelectColor.r, g: kSelectColor.g, b: kSelectColor.b)
        //设置ScrollLine 属性
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        scrollLine.backgroundColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        
    }
}

// MARK:- 监听Label 的点击
extension PageTitleView {
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer){
        
        //获取当前点击的Label
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        
        //获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        
        //切换文字的颜色
        currentLabel.textColor = UIColor.init(r: kSelectColor.r, g: kSelectColor.g, b: kSelectColor.b)
        oldLabel.textColor = UIColor.init(r: kNormalColor.r, g: kNormalColor.g, b: kNormalColor.b)
        
        //保存最新Label 的下标
        currentIndex = currentLabel.tag
        
        //滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        
        //添加动画
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        
        // 通知
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
}

extension PageTitleView {
    
    func setTitleWithProgress( progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        
        //  取出 sourceLabel / targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 处理滑动的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //处理颜色的渐变
        //取出变化的范围
        let colorDelta : (r : CGFloat,g : CGFloat,b : CGFloat) = (kSelectColor.r - kNormalColor.r , kSelectColor.g - kNormalColor.g , kSelectColor.b - kNormalColor.b)
        
        //变化 sourceLabel
        sourceLabel.textColor = UIColor.init(r: kSelectColor.r - colorDelta.r * progress, g: kSelectColor.g - colorDelta.g * progress, b: kSelectColor.b - colorDelta.b * progress)
        
        //变化 targetLabel
        targetLabel.textColor = UIColor.init(r: kNormalColor.r + colorDelta.r * progress, g: kNormalColor.g + colorDelta.g * progress, b: kNormalColor.b + colorDelta.b * progress)
        
        // 记录最新的Index
        currentIndex = targetIndex
        
    }
}
