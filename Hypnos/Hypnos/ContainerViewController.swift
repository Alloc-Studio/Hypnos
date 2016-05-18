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
    var leftView:UIView?
    var rightView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildView()
       // 添加pan手势
        let pan = UIPanGestureRecognizer(target: self, action:#selector(ContainerViewController.pan))
        view.addGestureRecognizer(pan)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if mainVc.view.frame.origin.x > 0 {
            rightView?.hidden = true
        }else if mainVc.view.frame.origin.x < 0{
            rightView?.hidden = false
        }
    }
    
     func pan(pan:UIPanGestureRecognizer) {
        
        let transP = pan.translationInView(view)
        let offsetX = transP.x
        mainVc.view.frame = frameWithOffsetX(offsetX)
        observeValueForKeyPath(nil, ofObject: nil, change: nil, context: nil)
        pan.setTranslation(CGPointZero, inView: view)
        
        if pan.state == UIGestureRecognizerState.Ended {
            var target = 0
            if mainVc.view.frame.origin.x > screenW * 0.5{
                target = 275
            }else if CGRectGetMaxX(mainVc.view.frame) < screenW * 0.5 {
                target = -250
            }
    
            let offsetXX = CGFloat(target) - mainVc.view.frame.origin.x
            
            UIView.animateWithDuration(0.25, animations: {
                self.mainVc.view.frame = target == 0 ? self.view.bounds:self.frameWithOffsetX(offsetXX
                )
            })
            
        }
        
    }
    
    // 设置子View
    private func setupChildView() {
        leftView = UIView(frame: view.bounds)
        leftView!.backgroundColor = UIColor.orangeColor()
        view.addSubview(leftView!)
        
        rightView = UIView(frame: view.bounds)
        rightView!.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(rightView!)
        
        mainVc.view.frame = view.bounds
        addChildViewController(mainVc)
        view.addSubview(mainVc.view)
        
    }
    
    // 手指往右移动，视图X轴也要往右移动（x++），y轴往下移动（y增加），尺寸缩放（按比例）
    private func frameWithOffsetX(offsetX:CGFloat) -> CGRect {
        
        var frame = mainVc.view.frame
        let screenH = UIScreen.mainScreen().bounds.size.height
        let offsetY = offsetX * 80 / screenW
        let preH = frame.size.height
        let preW = frame.size.width
        var curH = preH - 2 * offsetY
        if frame.origin.x < 0 {
            curH = preH + 2 * offsetY
        }
       
        let scale = curH / preH
        let curW = preW * scale
        frame.origin.x += offsetX
        let y = (screenH - curH) / 2
        frame.origin.y = y
        frame.size.height = curH
        frame.size.width = curW
        return frame
    }
    
    
}
