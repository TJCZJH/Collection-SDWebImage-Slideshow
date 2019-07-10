//
//  CycleCollectionView.swift
//  Collection轮播图
//
//  Created by Admin on 2019/7/10.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

private let CycleCellID = "CyleCellID"

class CycleCollectionView: UIView {
    
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    //定义属性
    var cycleTimer : Timer?
    var cycleModels : [CycleModel]?
    {
        didSet
        {
            //1.刷新collectionView
            collectionView.reloadData()
            //2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            //3.默认滚动到中间某个位置
            let indexPath = NSIndexPath(item:(cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            //4.添加定时器
            removeCycleTiemr()
            addCycleTimer()
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        //设备该控件不随着父控件的拉伸而拉伸
        autoresizingMask = []
        //注册Cell
        collectionView.register(UINib(nibName:"CycleCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: CycleCellID)
        
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

//提供一个快速创建View的类方法
extension CycleCollectionView
{
    class func recommendCycleView() -> CycleCollectionView
    {
        return Bundle.main.loadNibNamed("CycleCollectionView",owner : nil,options : nil)!.first as! CycleCollectionView
    }
}

// 遵守UICollectionView的数据代理协议
extension CycleCollectionView : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // 设置可以横向滑动的Item数量
        return (cycleModels?.count ?? 0 ) * 1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CycleCellID, for: indexPath) as! CycleCollectionViewCell
        cell.cycleModel = cycleModels?[indexPath.item % (cycleModels?.count)!]
        return cell
    }
}

// 遵守UICollectionView的代理协议
extension CycleCollectionView : UICollectionViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        //1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        //2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
        removeCycleTiemr()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        addCycleTimer()
    }
}

//对定时器的操作方法
extension CycleCollectionView{
    private func addCycleTimer()
    {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoop.Mode.common)
    }
    
    private func removeCycleTiemr()
    {
        cycleTimer?.invalidate() //从运行循环中移除
        cycleTimer = nil
    }
    @objc private func scrollToNext() {
        //1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        //2.滚动该位置
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
    }
}
