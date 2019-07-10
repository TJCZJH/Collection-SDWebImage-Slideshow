//
//  ViewController.swift
//  CycleCollection
//
//  Created by Admin on 2019/7/10.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
var cycleModels : [CycleModel] = [CycleModel]()

class ViewController: UIViewController {

    // 设置轮播
    lazy var cycleView : CycleCollectionView = {
        let cycleView = CycleCollectionView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: 44, width: UIScreen.main.bounds.width, height:200)
        return cycleView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(cycleView)
        requestCycleData {
            self.cycleView.cycleModels = cycleModels
        }
    }


    //请求无线轮播的数据
    func requestCycleData(finishCallback :@escaping () -> ())
    {
        NetworkTools.requestData(type:.GET, urlString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300" as AnyObject]) {
            (result) in
            //获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else {return}
            
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //3.字典转模型对象
            
            for dict in dataArray
            {
                cycleModels.append(CycleModel(dict : dict ) )
            }
            finishCallback()
        }
    }
}

