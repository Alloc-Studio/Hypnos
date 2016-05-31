//
//  CurrentRateViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/25.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

class CurrentRateViewController: UIViewController {

    @IBOutlet weak var heart: UIImageView!
    @IBOutlet weak var heartRate: UILabel!
    @IBOutlet weak var heartState: UILabel!
    @IBOutlet weak var synTime: UILabel!
    @IBOutlet weak var refreshBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        heartAnimation()
        syncTime()
        getHeartRate()
        
    }

    // 心率动画
    private func heartAnimation() {
        let anim = CABasicAnimation()
        anim.keyPath = "transform.scale"
        anim.toValue = 0.8
        anim.repeatCount = MAXFLOAT
        anim.removedOnCompletion = false
        anim.duration = 0.5
        anim.fillMode = kCAFillModeForwards
        heart.layer.addAnimation(anim, forKey: nil)
    }
    
    // 同步时间
    private func syncTime() {
        let time = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        let dateString = formatter.stringFromDate(time)
        synTime.text = "同步时间  \(dateString)"
        
    }
    
    // 获取心率
    private func getHeartRate() {
    
        let rate = Int(arc4random_uniform(160)+40)
        heartRate.text = String(rate)

        switch rate {
        case 1..<60:
            heartState.text = "心率过缓"
        case 140..<200:
            heartState.text = "心率过快"
        case 60..<140:
            heartState.text = "心率正常"
        default:
            fatalError("出错了。。。")
        }
    }
    
    
    @IBAction func refreshTime(sender: AnyObject) {
        
        let ani = CABasicAnimation()
        ani.keyPath = "transform.rotation.z"
        ani.toValue = M_PI * 2
        ani.repeatCount = 3
        ani.duration = 0.4
        refreshBtn.layer.addAnimation(ani, forKey: nil)
        let delay = dispatch_time(DISPATCH_TIME_NOW,Int64(1.0 * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) { 
            self.syncTime()
            self.getHeartRate()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
