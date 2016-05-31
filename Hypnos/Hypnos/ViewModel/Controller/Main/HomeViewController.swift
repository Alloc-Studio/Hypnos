//
//  HomeViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/18.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import SDCycleScrollView

class HomeViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(scrollviewM)
        scrollviewM.addSubview(search)
        cycleScrollView.imageURLStringsGroup = [temp1,temp2,temp3,temp4]
        scrollviewM.addSubview(cycleScrollView)
        scrollviewM.addSubview(hot)
        scrollviewM.addSubview(HotSelectedView.view)
        scrollviewM.addSubview(newSongs)
        scrollviewM.addSubview(musicSongs.view)
        
        presentMusicItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
        tabBarController?.tabBar.hidden = false
        
    }
    
    func moreBtn() {
        
        navigationController?.pushViewController(MoreArtistsViewController(), animated: true)
        
    }
    // 热门精选header
    private lazy var hot:UIView = {
        let hot = NSBundle.mainBundle().loadNibNamed("Header", owner: self, options: nil).last as! UIView
        hot.frame = CGRectMake(0, CGRectGetMaxY(self.cycleScrollView.frame) + 10, SCREEN_WIDTH, 30)
        for i in hot.subviews {
            if i.isKindOfClass(UIButton.self) {
                let btn = i as! UIButton
                btn.addTarget(self, action: #selector(HomeViewController.moreBtn), forControlEvents: .TouchUpInside)
            }
        }
        return hot
    }()
    
    // 新歌速递header
    private lazy var newSongs:UIView = {
        let new = NSBundle.mainBundle().loadNibNamed("Header", owner: self, options: nil).first as! UIView
        new.frame = CGRectMake(0, CGRectGetMaxY(self.HotSelectedView.view.frame) + 10, SCREEN_WIDTH, 30)
        return new
    }()
    
    // scrollview
    private lazy var scrollviewM:UIScrollView = {
        let sv = UIScrollView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44))
        sv.contentSize = CGSizeMake(0, CGRectGetMaxY(self.musicSongs.view.frame))
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    // 新歌速递
    private var musicSongs:MusicHallViewController {
        let ms = MusicHallViewController()
        ms.view.frame = CGRectMake(0, CGRectGetMaxY(self.newSongs.frame), SCREEN_WIDTH, 1150)
        addChildViewController(ms)
        return ms
    }
    
    // 热门精选
    private var HotSelectedView:HotSelectedViewController {
        let seletView = HotSelectedViewController()
        seletView.view.frame = CGRectMake(0, CGRectGetMaxY(self.hot.frame) + 10, SCREEN_WIDTH, 300)
        addChildViewController(seletView)
        return seletView
    }
    // 搜索框
    private lazy var search:SearchBar = {
        let search = SearchBar(frame: CGRectMake(10, 10, SCREEN_WIDTH-20, 30))
        return search
    }()
    // 轮播
    private lazy var cycleScrollView:SDCycleScrollView = {
        let cyv = SDCycleScrollView(frame: CGRectMake(10, CGRectGetMaxY(self.search.frame) + CGFloat(10), SCREEN_WIDTH-20, 170))
        cyv.autoScrollTimeInterval = 5.0
        cyv.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        cyv.showPageControl = true;
        cyv.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        return cyv
    }()
    
}

extension HomeViewController: MCItemPresentable{
    
    func showMuicController() {
        debugPrint("出来吧！播放器！")

    }
    
}


