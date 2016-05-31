//
//  Player.swift
//  Hypnos
//
//  Created by Fay on 16/5/31.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

class Player: MusicPlayerController {

    static let musicVc:MusicPlayerController = {
        let vc = MusicPlayerController()
        return vc
    }()
    //获取单例的类方法
    class func sharedPlayer() -> MusicPlayerController {
        return musicVc
    }

}
