//
//  NetworkService.swift
//  Hypnos
//
//  Created by Maru on 16/5/19.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import Foundation

class NetworkService {
    
    
    private struct API_Route {
        
        /**
         获取热门排行歌曲列表
         
         - returns: 热门歌曲列表的URL
         */
        static func Host_Song() -> String {
            return "http://music.douban.com/api/artist/chart?type=song&cb=%24.setp(0.5083166616968811)&app_name=music_artist&version=50"
        }
    }
}