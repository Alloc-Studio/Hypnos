//
//  HypnosUrl.swift
//  Hypnos
//
//  Created by Fay on 16/5/19.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

// 热门歌曲
let Hot_Song_Url = "http://music.douban.com/api/artist/chart?type=song&cb=%24.setp(0.5083166616968811)&app_name=music_artist&version=50"

// 热门歌手
let Hot_Artist_Url = "http://music.douban.com/api/artist/chart?type=artist&cb=%24.setp(0.5083166616968811)&app_name=music_artist&version=50"

// 搜索类别
let Search_Url = "http://music.douban.com/api/artist/search?q=&cb=%24.setp(0.5083166616968811)&app_name=music_artist&version=50"

// 歌手专辑
func TrackList(id:String) -> String { return "https://music.douban.com/api/artist/artist_playlist?id=\(id)&cb=%24.setp(0.8671221048571169)&app_name=music_artist&version=52" }

// 专辑歌曲
func ArtistTack(id:String) -> String { return "http://music.douban.com/api/artist/songs?id=\(id)&cb=%24.setp(0.7626912142150104)&app_name=music_artist&version=52" }

// 歌手活动
func Activity(id:String) -> String { return "http://music.douban.com/api/artist/artist_event?id=\(id)&cb=%24.setp(0.7148952656425536)&app_name=music_artist&version=52" }

// 歌手单曲
func ArtistSingleSong(id:String) -> String { return "http://music.douban.com/api/artist/artist_update?id=\(id)&cb=%24.setp(0.8595637178514153)&app_name=music_artist&version=52" }

// 搜索类型
enum APIType: Int {
    case HotSong = 1
    case HotArtist
    case Detail
    case MusicList
    case Activity
    case Album
    case Photo
    case Dynamic
    case LeaveMsg
    case Search
}


let temp1 = "http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1211/30/c4/16228064_1354258879632.jpg"
let temp2 = "http://image.tianjimedia.com/uploadImages/2012/012/2YXG0J416V69.jpg"
let temp3 = "http://www.pp3.cn/uploads/201509/2015091507.jpg"
let temp4 = "http://g.hiphotos.baidu.com/image/pic/item/1f178a82b9014a90b04cc438ae773912b21beec1.jpg"