//
//  HeartViewController.swift
//  Hypnos
//
//  Created by Maru on 16/5/24.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

class HeartViewController: UIViewController {

    var banner: SwitchBanner!
    var scrollView: UIScrollView!
    private var observerKey = 0
    
    // MARK: -  Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
        tabBarController?.tabBar.hidden = false
        
    }
}

extension HeartViewController {
    
    // MARK: - Private Method
    private func setupUI() {
        
        presentMusicItem()
        
        banner = SwitchBanner(frame: CGRectMake(0, 0, view.frame.width, 40), titles: ["当前心率","今日心率"])
        
        scrollView = UIScrollView(frame: CGRectMake(0, 40, view.frame.width, view.frame.height - 40))
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.contentSize = CGSizeMake(view.frame.width * 2, view.frame.height - 40)
        scrollView.pagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        
        let curr = CurrentRateViewController()
        addChildViewController(curr)
        curr.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 40)
        
        let today = TodayHeartRateViewController()
        addChildViewController(today)
        today.view.frame = CGRectMake(scrollView.frame.width, 0, scrollView.frame.width, scrollView.frame.height)
        
        scrollView.addSubview(curr.view)
        scrollView.addSubview(today.view)
        
        view.addSubview(banner)
        view.addSubview(scrollView)
        
        banner.configBindingScrollView(scrollView)
        
        
    }
}
extension HeartViewController: MCItemPresentable {
    
    func showMuicController() {
        guard let _ = Player.sharedPlayer().musicModel else {
            SweetAlert().showAlert("亲~", subTitle: "您还没有选择歌曲哦~~~", style: AlertStyle.CustomImag(imageFile: "recommend_cry"))
            return
        }
        navigationController?.pushViewController(Player.sharedPlayer(), animated: true)
    }
}
