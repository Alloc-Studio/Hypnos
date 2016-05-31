//
//  SpecialModel.swift
//  Hypnos
//
//  Created by Fay on 16/5/27.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import SwiftyJSON

class SpecialModel: NSObject {
    
    // 专辑ID
    var id:String?
    // 名称
    var title:String?
    
    init(dict:JSON) {
        super.init()
        id     = dict["id"].stringValue
        title  = dict["title"].stringValue
    }
    
    class func special(array: JSON) -> [SpecialModel]{
        var arrayM = [SpecialModel]()
        for json: JSON in array.arrayValue {
            arrayM.append(SpecialModel(dict: json))
        }
        return arrayM
    }
    
}
