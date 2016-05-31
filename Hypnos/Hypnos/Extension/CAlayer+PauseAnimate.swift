//
//  CAlayer+PauseAnimate.swift
//  Hypnos
//
//  Created by Fay on 16/5/22.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

extension CALayer {
    
    func pauseAnimate() {
        let pausedTime = self.convertTime(CACurrentMediaTime(), fromLayer: nil)
        self.speed = 0.0
        self.timeOffset = pausedTime;
    }
    
    func resumeAnimate() {
        let pausedTime = self.timeOffset
        self.speed = 1.0
        self.timeOffset = 0.0
        self.beginTime = 0.0
        let timeSincePause = self.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
        self.beginTime = timeSincePause
    }
    
    
}
