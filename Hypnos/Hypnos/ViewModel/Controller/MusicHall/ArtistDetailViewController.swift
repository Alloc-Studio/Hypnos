//
//  ArtistDetailViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/27.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

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
        
        scrollView = UIScrollView(frame: CGRectMake(0, CGRectGetMaxY(banner.frame), SCREEN_WIDTH, view.frame.height-CGRectGetMaxY(banner.frame)-40))
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.contentSize = CGSizeMake(view.frame.width * 2, SCREEN_HEIGHT-CGRectGetMaxY(banner.frame)-40)
        scrollView.pagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        let activity = ActivityViewController()
        activity.artist = artist
        addChildViewController(activity)
        activity.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(banner.frame)-44)
        
        let special = SpecialViewController()
        special.artist = artist
        addChildViewController(special)
        special.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(banner.frame)-40)
        
        scrollView.addSubview(activity.view)
        scrollView.addSubview(special.view)
        
        view.addSubview(banner)
        view.addSubview(scrollView)
        
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