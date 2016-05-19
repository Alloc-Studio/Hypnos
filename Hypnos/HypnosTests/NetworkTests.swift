//
//  NetworkTests.swift
//  Hypnos
//
//  Created by Maru on 16/5/19.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import XCTest
@testable import Hypnos
import Alamofire
import SwiftyJSON

class NetworkTests: XCTestCase {
    

    func testHotSingleMusic() {
        
        Alamofire
            .request(.GET, "http://music.douban.com/api/artist/chart?type=song&cb=%24.setp(0.5083166616968811)&app_name=music_artist&version=50")
            .response { (request, response, data, error) in
                XCTAssertNil(error)
        }
        
        Alamofire
            .request(.GET, "http://music.douban.com/api/artist/chart?type=song&cb=%24.setp(0.5083166616968811)&app_name=music_artist&version=50")
            .responseData { (response) in
                let range = NSRange(location: 27, length: (response.result.value?.length)! - 29)
                let a = response.result.value?.subdataWithRange(range)
                let json = JSON(data: a!)
                let str = NSString(data: a!, encoding: 0)
                
                debugPrint(json)
    }
}