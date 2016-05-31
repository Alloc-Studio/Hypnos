//
//  DataTool.swift
//  Hypnos
//
//  Created by Fay on 16/5/19.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import SVProgressHUD


class DataTool: NSObject {

    // 获取热门歌曲列表
    class func getHotSongList(successCallback:(obj:AnyObject)->()) {
        
        
        HttpTool.getDataList(Hot_Song_Url, failCallback: { (error) in
            
            SVProgressHUD.showErrorWithStatus("加载失败")
            
            }) { (obj) in
                
                successCallback(obj:HotSongsModel.songs(obj["songs"].array!) as AnyObject)
        }
    }
    
    // 获取热门歌手列表
    class func getHotArtistList(successCallback:(obj:AnyObject)->()) {
        
        
        HttpTool.getDataList(Hot_Artist_Url, failCallback: { (error) in
            
            SVProgressHUD.showErrorWithStatus("加载失败")
            
        }) { (obj) in
            
            successCallback(obj:HotArtistsModel.artists(obj["artists"].array!) as AnyObject)
        }
    }

     // 获取歌手活动
    class func getArtistActivity(id:String,successCallback:(obj:AnyObject)->()) {
        
        HttpTool.getDataList(Activity(id), failCallback: { (error) in
            
            SVProgressHUD.showErrorWithStatus("加载失败")
            
            }) { (obj) in
                
                successCallback(obj: HotArtistsModel(dict: obj) as AnyObject)
        }

    }

    // 获获取歌手单曲
    class func getSpecial(id:String,successCallback:(obj:AnyObject)->()) {
        
        HttpTool.getDataList(TrackList(id), failCallback: { (error) in
            
            SVProgressHUD.showErrorWithStatus("加载失败")
            
        }) { (obj) in
            
            successCallback(obj: HotArtistsModel(dict: obj) as AnyObject)
        }
        
    }

    // 获取专辑单曲
    class func getSpecialSongs(id:String,successCallback:(obj:AnyObject)->()) {
        
        HttpTool.getDataList(ArtistTack(id), failCallback: { (error) in
            
            SVProgressHUD.showErrorWithStatus("加载失败")
            
        }) { (obj) in
            
            successCallback(obj: SpecialSongsModel(dict: obj) as AnyObject)
        }
        
    }

    
    
}
