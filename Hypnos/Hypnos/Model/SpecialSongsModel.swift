//
//  SpecialSongsModel.swift
//  Hypnos
//
//  Created by Fay on 16/5/27.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import SwiftyJSON

class SpecialSongsModel: NSObject {
    // 专辑ID
    var playlist:SpecialModel?
    // id
    var artist_id:String?
    // 歌手名
    var artist_name:String?
    // 歌曲
    var songs:[HotSongsModel]?
    
    init(dict:JSON) {
        super.init()
        playlist     = SpecialModel(dict: dict["playlist"])
        artist_id  = dict["artist_id"].stringValue
        artist_name     = dict["artist_name"].stringValue
        songs  =  HotSongsModel.specialSongs(dict["songs"])
    }
    
    class func specialSongs(array: JSON) -> [SpecialSongsModel]{
        var arrayM = [SpecialSongsModel]()
        for json: JSON in array.arrayValue {
            arrayM.append(SpecialSongsModel(dict: json))
        }
        return arrayM
    }

}
