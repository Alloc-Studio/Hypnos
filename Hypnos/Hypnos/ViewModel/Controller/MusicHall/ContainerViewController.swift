//
//  ContainerViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/18.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    let mainVc = MainViewController()
    let screenW = UIScreen.mainScreen().bounds.size.width
    var leftView: LeftSliderView!
    var dimmingView: UIView!
    
    private var didShowSlider: Bool! {
        didSet {
            if didShowSlider == true {
                dimmingView.hidden = false
            }else {
                dimmingView.hidden = true
            }
        }
    }
    
    private let sliderWidth: CGFloat = 200.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildView()
        
        didShowSlider = false
        
        let sliderPan = UIPanGestureRecognizer(target: self, action: #selector(self.sliderPan))
        view.addGestureRecognizer(sliderPan)
        
    }
    
    
    func sliderPan(pan: UIPanGestureRecognizer) {
        
        if mainVc.view.frame.origin.x < 0 {
            mainVc.view.frame.origin.x = 0
            return
        }
        
        let offset = pan.translationInView(view)
        
        var originFrame = view.frame
        var originLef = leftView.frame
        
        if offset.x > 0 && offset.x < sliderWidth {
            originFrame.origin.x = offset.x
            originLef.origin.x = -sliderWidth + offset.x
        }
        else if offset.x < 0 && offset.x > -sliderWidth{
            originFrame.origin.x = sliderWidth + offset.x
            originLef.origin.x = offset.x
        }
        else if offset.x > 0 && offset.x > sliderWidth {
            originFrame.origin.x = sliderWidth
            originLef.origin.x = 0
        }else if offset.x < 0 && offset.x < -sliderWidth {
            originFrame.origin.x = 0
            originLef.origin.x = -sliderWidth
        }
        
        if (offset.x > 0 && didShowSlider == false) || (offset.x < 0 && didShowSlider == true) {
            mainVc.view.frame = originFrame
            leftView.frame = originLef
        }

        if pan.state == .Ended && (offset.x > -sliderWidth || offset.x < sliderWidth) {
            var targetFrame: CGRect?
            var targetX: CGFloat?
            if mainVc.view.frame.origin.x > 100 {
                didShowSlider = true
                targetX = 0
                targetFrame = CGRectMake(sliderWidth, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
            }else {
                didShowSlider = false
                targetX = -sliderWidth
                targetFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
            }
            UIView.animateWithDuration(0.3, animations: {
                self.leftView.frame.origin.x = targetX!
                self.mainVc.view.frame = targetFrame!
            })
        }
        
}

    
    // 设置子View
    private func setupChildView() {
        
        leftView = NSBundle.mainBundle().loadNibNamed(String(LeftSliderView), owner: nil, options: nil).first as! LeftSliderView
        leftView.frame = CGRectMake(0, 0, sliderWidth, SCREEN_HEIGHT)
        view.addSubview(leftView!)
        
        mainVc.view.frame = view.bounds
        addChildViewController(mainVc)
        view.addSubview(mainVc.view)
        
        dimmingView = UIView(frame: self.view.bounds)
        dimmingView.hidden = true
        dimmingView.backgroundColor = UIColor.blackColor()
        dimmingView.alpha = 0.3
        mainVc.view.addSubview(dimmingView)
        
    }
    

}
