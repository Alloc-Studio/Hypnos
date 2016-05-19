//
//  WildogTests.swift
//  Hypnos
//
//  Created by Maru on 16/5/19.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import XCTest
@testable import Hypnos
import Wilddog

class WildogTests: XCTest {
    
    let ref = Wilddog(url: "https://hypnos.wilddogio.com")
    
    func testWildogLogin() {
        
        ref.authUser("475435200@qq.com", password: "zhang=19950406") { (error, data) in
            XCTAssertNil(error)
        }
    }
    
    func testWildogRegister() {
        
        ref.createUser("446777920@qq.com", password: "123456") { (error) in
            XCTAssertNil(error)
        }
    }
}
