//
//  CycleCollectionViewCell.swift
//  Collection轮播图
//
//  Created by Admin on 2019/7/10.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import SDWebImage

class CycleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var cycleModel : CycleModel?
    {
        didSet{
            
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string:(cycleModel?.pic_url)!)
        
            SDImageCache.shared.queryCacheOperation(forKey:cycleModel?.pic_url) { (image, data, cacheType) in
                if image != nil {
                    print("在缓存中找到了")
                    self.iconImageView.image = image
                }else{
                    SDWebImageManager.shared.loadImage(with: iconURL, options: [], context: [:], progress: { (min, max, url) in
                        print("加载中")
                    }) { (image, data, error, cacheType, finished, url) in
                        if (image != nil){
                            self.iconImageView.image = image
                            print("图片加载完成")
                        }else{
                            print("图片加载失败")
                        }

                    }
                }
            }
        }
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
