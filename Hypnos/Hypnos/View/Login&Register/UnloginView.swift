//
//  UnloginView.swift
//  Hypnos
//
//  Created by Maru on 16/5/23.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

class UnloginView: UIView {
    
    var loginMotion: (() -> ())?

    @IBAction func showLoginController(sender: AnyObject) {
        if let action = loginMotion {
            action()
        }
    }
}
