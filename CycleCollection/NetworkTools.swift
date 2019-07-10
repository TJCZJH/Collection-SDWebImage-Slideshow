//
//  NetworkTools.swift
//  CycleCollection
//
//  Created by Admin on 2019/7/10.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import Alamofire
enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    // 封装请求方法
    class func requestData(type : MethodType, urlString : String, parameters : [String : AnyObject]? = nil , finishedCallback :@escaping ( _ result : AnyObject) -> ()) {
        // 判断请求范式
        
        let method = type == .GET ? Alamofire.HTTPMethod.get : Alamofire.HTTPMethod.post
        
        // 发送请求，并且将请求到的数据回调
        Alamofire.request(urlString,method : method,parameters: parameters).responseJSON
            {
                (response) in
                guard let result = response.result.value
                    else {
                        print(response.result.error!)
                        return
                }
                finishedCallback(result as AnyObject)
                
        }
    }
}


