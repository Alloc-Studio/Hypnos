//
//  HotSongsModel.swift
//  Hypnos
//
//  Created by Fay on 16/5/19.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import SwiftyJSON

class HotSongsModel: NSObject {

    // 数目
    var count:Int?
    // 图片
    var picture:String?
    // 名称
    var name:String?
    // 作者
    var artist:String?
    var rank:Int?
    // id
    var id:String?
    // 歌曲长度
    var length:String?
    // 作者id
    var artist_id:String?
    // 歌曲地址
    var src:String?
    // 暂时不知道是什么id
    var widget_id:String?
    
    init(dict:JSON) {
        super.init()
        count     = dict["count"].intValue
        picture   = dict["picture"].stringValue
        name      = dict["name"].stringValue
        artist    = dict["artist"].stringValue
        rank      = dict["rank"].intValue
        id        = dict["id"].string
        length    = dict["length"].stringValue
        artist_id = dict["artist_id"].stringValue
        src       = dict["src"].stringValue
        widget_id = dict["widget_id"].stringValue
    }
    
    
    class func songs(array:[JSON])-> NSMutableArray {
        let arr: NSMutableArray = []
        for item in array {
            arr.addObject(HotSongsModel(dict: item))
        }
        return arr
    }
    
    class func specialSongs(array: JSON) -> [HotSongsModel]{
        var arrayM = [HotSongsModel]()
        for json: JSON in array.arrayValue {
            arrayM.append(HotSongsModel(dict: json))
        }
        return arrayM
    }
}
