//
//  NetWorkToos.swift
//  DouYuZB
//
//  Created by ninan lin on 2018/11/14.
//  Copyright © 2018年 ninan lin. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetWorkTools{
    
    class func requestData(type : MethodType , urlString : String , parameters : [String : Any]? = nil , finishedCallback : @escaping (_ result :Any) -> ()) {
        
        //获取请求类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //开始请求
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            
            guard let result = response.result.value else{
                print(response.result.error ?? "Not error")
                return
            }
            
            // 结果回调
            finishedCallback(result)
            
        }
        
    }
   
}

