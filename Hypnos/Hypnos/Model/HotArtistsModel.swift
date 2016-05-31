//
//  HotArtistsModel.swift
//  Hypnos
//
//  Created by Fay on 16/5/19.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import SwiftyJSON

class HotArtistsModel: NSObject {
    
    // 图片
    var picture:String?
    // 风格
    var style:String?
    // 是否添加
    var added:String?
    // 名称
    var name:String?
    // 未知
    var rank:Int?
    // 成员
    var member:String?
    // id
    var follower:String?
    // 类型
    var type:String?
    // 作者id
    var id:String?
    // 活动
    var events:[ActivityModel]?
    // 专辑
    var playlist:[SpecialModel]?
    

    init(dict:JSON) {
        super.init()
        picture  = dict["picture"].stringValue
        style    = dict["style"].stringValue
        added    = dict["added"].stringValue
        name     = dict["name"].stringValue
        rank     = dict["rank"].intValue
        member   = dict["member"].stringValue
        follower = dict["follower"].stringValue
        type     = dict["type"].stringValue
        id       = dict["id"].string
        events   = ActivityModel.activities(dict["events"])
        playlist = SpecialModel.special(dict["playlist"])
    }
    
    class func artists(array:[JSON])-> NSMutableArray {
        let arr: NSMutableArray = []
        for item in array {
            arr.addObject(HotArtistsModel(dict: item))
        }
        return arr
    }
    

}



