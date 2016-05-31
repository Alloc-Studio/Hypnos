//
//  LoginTextFiled.swift
//  Hypnos
//
//  Created by Maru on 16/5/21.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

class LoginTextFiled: UITextField {
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(bounds.width * 0.12 , 0, bounds.width * 0.8, bounds.height)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(bounds.width * 0.12 , 0, bounds.width * 0.8, bounds.height)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(bounds.width * 0.12 , 0, bounds.width * 0.8, bounds.height)
    }

}
