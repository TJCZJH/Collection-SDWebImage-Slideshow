//
//  CycleModel.swift
//  DYZB
//
//  Created by Admin on 10/03/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // 标题
    @objc var title : String = ""
    // 展示图片的地址
    @objc var pic_url : String = ""
    // 自定义构造函数
    init(dict : [String : NSObject])
    {
        super.init()
        setValuesForKeys(dict)
    }
    
     override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
