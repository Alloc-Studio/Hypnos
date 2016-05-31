//
//  String+Hypnos.swift
//  Hypnos
//
//  Created by Fay on 16/5/20.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

extension String {
    
    var url: NSURL {
        return NSURL(string: self)!
    }
    
    static func stringWithTime(time:NSTimeInterval) -> String {
       
        var timeT:String = " "
        
        if time > 0.0 {
            let all:Int=Int(time)
            let m:Int=all % 60
            let f:Int=Int(all/60)
            
            if f<10{
                timeT="0\(f):"
            }else {
                timeT="\(f)"
            }
            if m<10{
                timeT+="0\(m)"
            }else {
                timeT+="\(m)"
            }
        }
        return timeT
        
    }
    
}