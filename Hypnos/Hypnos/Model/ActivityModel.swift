//
//  ActivityModel.swift
//  Hypnos
//
//  Created by Fay on 16/5/27.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import SwiftyJSON

class ActivityModel: NSObject {
    
    // 活动名称
    var title:String?
    // 活动图片
    var icon:String?
    // 活动网址
    var url:String?
    // 活动月
    var month:Int?
    // 活动日
    var day:Int?
    // 活动详情
    var abstract:String?
    
    init(dic:JSON) {
        super.init()
        title = dic["title"].stringValue
        icon = dic["icon"].stringValue
        url = dic["url"].stringValue
        month = dic["month"].intValue
        day = dic["day"].intValue
        abstract = dic["abstract"].stringValue
        
    }
    
    class func activities(array: JSON) -> [ActivityModel]{
        var arrayM = [ActivityModel]()
        for json: JSON in array.arrayValue {
            arrayM.append(ActivityModel(dic: json))
        }
        return arrayM
    }
    
    
}
