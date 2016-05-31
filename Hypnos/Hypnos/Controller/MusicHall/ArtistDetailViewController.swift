//
//  ArtistDetailViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/27.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import Cartography

class ArtistDetailViewController: UIViewController {

    
    @IBOutlet weak var ablumImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var style     : UILabel!
    @IBOutlet weak var member    : UILabel!
    @IBOutlet weak var follower  : UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var headerView: UIView!
    var banner: SwitchBanner!
    var scrollView: UIScrollView!
    var artist:HotArtistsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setBlurView()
        
        title = artist?.name
        artistName.text = artist?.name
        style.text = artist?.style
        follower.text = "\(artist!.follower!) 人关注"
        background.kf_setImageWithURL((artist?.picture?.url)!)
        ablumImage.kf_setImageWithURL((artist?.picture?.url)!)
    }
    
    // 添加毛玻璃模糊效果
    private func setBlurView() {
        let blurView = FXBlurView(frame: CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(background.frame)))
        blurView.blurRadius = 40
        blurView.tintColor = UIColor.blackColor()
        blurView.dynamic = true
        background.addSubview(blurView)
    }
    
}

extension ArtistDetailViewController {
    
    func setUI() {
        banner = SwitchBanner(frame: CGRectMake(0, CGRectGetMaxY(headerView.frame), SCREEN_WIDTH, 40), titles: ["曲库","活动"])
        view.addSubview(banner)
        
        scrollView = UIScrollView(frame: CGRectMake(0, banner.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - banner.bottom - 49))
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.contentSize = CGSizeMake(view.width * 2, 0)
        scrollView.pagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        view.addSubview(scrollView)
        constrain(scrollView, banner) { (view, banner) in
            view.left == banner.left
            view.right == banner.right
            view.top == banner.bottom
            view.bottom == (view.superview?.bottom)!
        }
        
        let activity = ActivityViewController()
        activity.artist = artist
        addChildViewController(activity)
        scrollView.addSubview(activity.view)
        activity.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, scrollView.height)
        
        let special = SpecialViewController()
        special.artist = artist
        addChildViewController(special)
        scrollView.addSubview(special.view)
        special.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, scrollView.height)
        
        banner.configBindingScrollView(scrollView)
        
        banner.configIndexMotion { [unowned self] (index) in
            if index == 0 {
                self.scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
            }else {
                self.scrollView.setContentOffset(CGPointMake(self.view.frame.width, 0), animated: true)
            }
        }

    }
    
}