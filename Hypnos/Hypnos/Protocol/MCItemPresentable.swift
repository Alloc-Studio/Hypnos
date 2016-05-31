//
//  MusciItemType.swift
//  Hypnos
//
//  Created by Maru on 16/5/23.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import Foundation

@objc
protocol MCItemPresentable: class {
    
    optional func presentMusicItem()
    
    func showMuicController()
}

extension MCItemPresentable where Self: UIViewController {
    
    func presentMusicItem() {
        
        let music = UIBarButtonItem(image: UIImage(named: "nav-menu")?.imageWithRenderingMode(.AlwaysOriginal), landscapeImagePhone: nil, style: .Plain, target: self, action:#selector(MCItemPresentable.showMuicController))
        
        music.imageInsets = UIEdgeInsetsMake(10, 10, 5, 5)
        
        navigationItem.rightBarButtonItems = [music]
        
    }
}