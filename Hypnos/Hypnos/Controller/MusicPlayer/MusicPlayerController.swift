 //
//  MusicPlayerController.swift
//  Hypnos
//
//  Created by Fay on 16/5/22.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import MediaPlayer
import Kingfisher

class MusicPlayerController: UIViewController {

    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var singer: UILabel!
    @IBOutlet weak var albumView: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var slider: UISlider!

    var progressTimer:NSTimer? // 计时器
    var currentPlayer:MPMoviePlayerController? // 播放器
    var playingMusic:HotSongsModel? //正在播放的歌曲
    
    // 歌曲模型数组
    var musics:[HotSongsModel] = []
    var musicModel:HotSongsModel? {
        didSet{
            currentPlayer    = MPMoviePlayerController(contentURL: NSURL(string:musicModel!.src!))
            currentPlayer?.play()
            playingMusic     = musicModel
            songName.text    = musicModel?.name
            singer.text      = musicModel?.artist
            albumView.kf_setImageWithURL((musicModel?.picture?.url)!)
            background.kf_setImageWithURL((musicModel?.picture?.url)!)
            totalTime.text   = musicModel?.length
            playBtn.selected = true
        }
    }
    
    // MARK:- slider事件处理
    @IBAction func sliderValueChanged(sender: AnyObject) {
        let time = (currentPlayer?.duration)! * NSTimeInterval(slider.value)
        currentTime.text = String.stringWithTime(time)
    }
    
    @IBAction func dimiss(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func startSlider(sender: AnyObject) {
        removeProgressTimer()
    }

    // 拖动结束
    @IBAction func endSilder(sender: AnyObject) {
        
        currentPlayer?.currentPlaybackTime = NSTimeInterval(slider.value) * (currentPlayer?.duration)!
        addProgressTimer()
    }
    
    // 点击slider
    @IBAction func sliderClick(sender: AnyObject) {
        
        // 获取点击位置
        let point = sender.locationInView(sender.view)
        // 获取点击的在slider长度中占据的比例
        let ratio = point.x / slider.bounds.size.width
        // 改变播放时间
        currentPlayer?.currentPlaybackTime = NSTimeInterval(ratio) * (currentPlayer?.duration)!
        
        updateProgressInfo()
        
    }
    
    // MARK:- 歌曲控制事件处理
    // 下一曲
    @IBAction func next(sender: AnyObject) {
        currentPlayer?.pause()
        musicModel = nextMusic()
        startPlay()
        updateProgressInfo()
        if playBtn.selected {
            albumView.layer.resumeAnimate()
        }
    }
    
    // 上一曲
    @IBAction func previous(sender: AnyObject) {
        currentPlayer?.pause()
        musicModel = previousMusic()
        startPlay()
        updateProgressInfo()
        if playBtn.selected {
            albumView.layer.resumeAnimate()
        }
    }
  
    // 开始或者暂停
    @IBAction func playOrPause(sender: AnyObject) {
        playBtn.selected = !playBtn.selected
        if playBtn.selected {
            currentPlayer?.play()
            addProgressTimer()
            albumView.layer.resumeAnimate()
        }else{
            currentPlayer?.pause()
            removeProgressTimer()
            albumView.layer.pauseAnimate()
        }
    }

    // 下一曲
    private func nextMusic() -> HotSongsModel {
        // 拿到当前歌曲下标
        let currentIndex:NSInteger = musics.indexOf(playingMusic!)!
        var nextIndex = currentIndex + 1;
        if nextIndex >= musics.count {
            nextIndex = 0;
        }
        let nextMusic:HotSongsModel = musics[nextIndex]
        return nextMusic
    }

    // 上一曲
    func previousMusic() -> HotSongsModel {
        // 拿到当前歌曲下标
        let currentIndex:NSInteger = musics.indexOf(playingMusic!)!
        var previousIndex = currentIndex - 1;
        if previousIndex <  0 {
            previousIndex = musics.count - 1;
        }
        
        let previousMusic:HotSongsModel = musics[previousIndex]
        return previousMusic
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setBlurView()
        slider.setThumbImage(UIImage(named: "home_progress_circle"), forState:.Normal)
        
        //setData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBarHidden = true
        tabBarController?.tabBar.hidden = true
        startPlay()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setAlbumCorner()
    }
    
    // 加载数据
    func setData() {
        currentPlayer    = MPMoviePlayerController(contentURL: NSURL(string:musicModel!.src!))
        currentPlayer?.play()
        playingMusic     = musicModel
        songName.text    = musicModel?.name
        singer.text      = musicModel?.artist
        albumView.kf_setImageWithURL((musicModel?.picture?.url)!)
        background.kf_setImageWithURL((musicModel?.picture?.url)!)
        totalTime.text   = musicModel?.length
        playBtn.selected = true
    }
    
    
    // 开始播放音乐
    private func startPlay() {
        removeProgressTimer()
        addProgressTimer()
        startAlbumAnimate()
    }
    
    
    // 定时器操作
    func addProgressTimer() {
        updateProgressInfo()
        progressTimer = NSTimer(timeInterval: 1.0, target: self, selector:#selector(MusicPlayerController.updateProgressInfo), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(progressTimer!, forMode: NSRunLoopCommonModes)
    }
    
    // 移除定时器
    private func removeProgressTimer() {
        progressTimer?.invalidate()
        progressTimer = nil
    
    }
    
    // 更新进度界面
     func updateProgressInfo() {
        currentTime.text = String.stringWithTime((currentPlayer?.currentPlaybackTime)!)
        slider.value = Float((currentPlayer?.currentPlaybackTime)! / (currentPlayer?.duration)!)
        
        let delay = dispatch_time(DISPATCH_TIME_NOW,Int64(5.0 * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            if (self.currentPlayer?.currentPlaybackTime)! >= (self.currentPlayer?.duration)! {
                
                self.musicModel = self.nextMusic()
                self.startPlay()
                self.updateProgressInfo()
                if self.playBtn.selected {
                    self.albumView.layer.resumeAnimate()
                }
            }
        }
    }
    
    // 设置圆角
    private func setAlbumCorner() {
        albumView.layer.cornerRadius = albumView.bounds.size.width / 2
        albumView.layer.masksToBounds = true
        albumView.layer.borderWidth = 8.0
        albumView.layer.borderColor = HypnosConfig.borderColor.CGColor
        
    }

    // 转盘动画
    private func startAlbumAnimate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = M_PI * 2
        rotation.repeatCount = Float(CGFloat.max)
        rotation.duration = 40
        albumView.layer.addAnimation(rotation, forKey: nil)
    }
    
    // 添加毛玻璃模糊效果
    private func setBlurView() {
        
        let blurView = FXBlurView(frame: self.view.bounds)
        blurView.blurRadius = 50
        blurView.tintColor = UIColor.blackColor()
        blurView.dynamic = true
        background.addSubview(blurView)
    }
    
   }
