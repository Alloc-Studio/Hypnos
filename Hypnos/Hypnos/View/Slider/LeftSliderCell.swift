//
//  LeftSliderCellTableViewCell.swift
//  Hypnos
//
//  Created by Maru on 16/5/26.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import Cartography

class LeftSliderCell: UITableViewCell {
    
    let icon: UIImageView!
    let title: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.icon = UIImageView.init()
        self.title = UILabel.init()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(icon)
        contentView.addSubview(title)
        self.icon.contentMode = .ScaleAspectFill
        constrain(icon, title) { (icon, title) in
            icon.left ==  ((icon.superview)?.left)! + 20
            icon.centerY == ((icon.superview)?.centerY)!
            icon.width == 2
            icon.height == 20
            
            title.left == icon.right + 20
            title.centerY == ((title.superview)?.centerY)!
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

    }

}
