//
//  KeyboardProtocol.swift
//  Hypnos
//
//  Created by Maru on 16/5/22.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import Foundation

@objc public protocol KeyboardProtocol {
    
    optional func keyboardWillChange(notification: NSNotification)
}

extension KeyboardProtocol where Self: UIViewController {
    

    func keyboardFrameWillChange(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as?
            UInt
            
            let changeFrame = value?.CGRectValue()
            
            UIView.animateWithDuration(duration!, delay: 0, options: UIViewAnimationOptions(rawValue: curve!), animations: {
                
                self.view.frame = CGRectMake(0, (changeFrame?.origin.y)! - self.view.frame.height, self.view.frame.width, self.view.frame.height)
                
                }, completion: nil)
            
        }
    }
}