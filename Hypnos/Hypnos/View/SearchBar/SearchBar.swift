//
//  SearchBar.swift
//  Hypnos
//
//  Created by Fay on 16/5/23.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

class SearchBar: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font                   = UIFont.systemFontOfSize(15)
        placeholder            = "  请输入要搜索的歌曲/歌手"
        background             = UIImage(named: "home-search-input")

        let searchIcon         = UIImageView(frame: CGRectMake(0, 0, 20, 20))
        searchIcon.image       = UIImage(named: "home-search-btn")
        searchIcon.contentMode = .ScaleAspectFit
        searchIcon.frame.size  = CGSizeMake(18, 18)
        rightView              = searchIcon
        rightViewMode          = .Always

        let leftView           = UIView(frame: CGRectMake(0,0,5,18))
        self.leftView          = leftView
        leftViewMode           = .Always
        tintColor              = HypnosConfig.DefaultThemeColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func rightViewRectForBounds(bounds: CGRect) -> CGRect {
       var textRect = super.rightViewRectForBounds(bounds)
       textRect.origin.x -= 10
       return textRect
    }
    
    override func leftViewRectForBounds(bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRectForBounds(bounds)
        textRect.origin.x += 5
        return textRect

    }
}
