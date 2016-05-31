//
//  RecommendBanner.swift
//  Hypnos
//
//  Created by Maru on 16/5/23.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

class RecommendBanner: UIView {

    @IBOutlet weak var rateLable: UILabel!
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        backgroundColor = HypnosConfig.DefaultThemeColor
    }

}
