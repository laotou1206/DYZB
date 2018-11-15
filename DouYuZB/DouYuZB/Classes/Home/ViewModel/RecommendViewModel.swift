//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/15.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit

class RecommendViewModel{
    
    //MARK- 懒加载属性
    private lazy var anchorGroups : [AnchorGroup] = [AnchorGroup] ()
    private lazy var hotGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
    //轮播数据的数组
   private lazy var cycleModels : [CycleModel] = [CycleModel]()
    
}

// MARK:- 发送网络请求

extension RecommendViewModel{
    
    // 请求推荐数据
    func requestData(callback : @escaping (_ anchorGroups :[AnchorGroup]) -> ())  {
        
        // 1: 参数
        let parameters : [String : Any] = ["limit" : 4 , "offset" : 0 , "time" : NSDate.getCurrentTime()]
        
        // 2: 创建Group 队列
        let dGroup = DispatchGroup.init()
        
        //3：请求第一部分 推荐数据
        //入队
        dGroup.enter()
        NetWorkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (response) in
            //将response 转成字典类型
            guard let result = response as? [String : Any] else{ return }
            
            //根据 data 获取数组
            guard let dataArray =  result["data"] as? [[String : Any]] else { return }
            
            self.hotGroup.tag_name = "热门"
            self.hotGroup.icon_image = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.hotGroup.anchors.append(anchor)
            }
            
            //出队
            dGroup.leave()
            
            print("请求到热门数据")
            
        }
        
        // 4：请求第二部分 颜值数据
        //入队
        dGroup.enter()
        NetWorkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (response) in
            //将response 转成字典类型
            guard let result = response as? [String : Any] else{ return }
            
            //根据 data 获取数组
            guard let dataArray =  result["data"] as? [[String : Any]] else { return }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_image = "home_header_phone"
            
            for dict in dataArray {
               let anchor = AnchorModel(dict: dict)
               self.prettyGroup.anchors.append(anchor)
            }
            //出队
            dGroup.leave()
            print("请求到颜值数据")
        }
        
        // 5: 请求第三部分 游戏数据
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom?limit=4&offset=0&time=1542251812
        //入队
        dGroup.enter()
        NetWorkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (response) in
            //将response 转成字典类型
            guard let result = response as? [String : Any] else{ return }
            
            //根据 data 获取数组
            guard let dataArray =  result["data"] as? [[String : Any]] else { return }
            
            //遍历数组 获取字典 将字典转出对象
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            //出队
            dGroup.leave()
            print("请求到游戏数据")
        }
        
            // 6 : 所有数据都请求到 进行排序
            dGroup.notify(queue: .main) {
            print("所有数据请求完成")
            self.anchorGroups.insert(self.hotGroup, at: 0)
            self.anchorGroups.insert(self.prettyGroup, at: 1)
            //请求完成的回调
            callback(self.anchorGroups)

        }
    }
    
    
    // 请求轮播数据http://www.douyutv.com/api/v1/slide/6?version=2.300
    
    func requestcycleData(callback :  @escaping (_ cycleModes : [CycleModel]) -> ()) {
        
        NetWorkTools.requestData(type: .get, urlString: "http://www.douyutv.com/api/v1/slide/6",parameters: ["version" : "2.300"]) { (response) in
            
            // 获取整个字典数据
            guard let result = response as? [String : Any] else { return }
            
            // 根据Data 的key 获取数据
            guard let dataArray = result["data"] as? [[String : Any]] else { return }
            
            // 字典转对象
            for dict in dataArray{
                self.cycleModels.append(CycleModel(dic: dict))
            }
            callback(self.cycleModels)
            
        }
        
    
    }
  
}
