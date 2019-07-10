//
//  CycleCollectionViewCell.swift
//  Collection轮播图
//
//  Created by Admin on 2019/7/10.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class CycleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var cycleModel : CycleModel?
    {
        didSet{
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string:(cycleModel?.pic_url)!)
//            iconImageView.kf.setImage(with: iconURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
