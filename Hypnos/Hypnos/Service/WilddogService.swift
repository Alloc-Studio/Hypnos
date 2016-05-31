//
//  WildogService.swift
//  Hypnos
//
//  Created by Maru on 16/5/21.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import Wilddog

class WilddogService {
    
    /// 野狗对象引用
    static let reference = Wilddog(url: "https://hypnos.wilddogio.com")!
    
    /// 传值所用的相关KEY
    static let nameKey  = "username"
    static let emailKey = "email"
    static let pwdKey   = "password"
    
    typealias AuthClosure = (data: WAuthData) -> ()
    typealias ErrorClosure = (error: NSError) -> ()
    typealias MotionClouser = () -> ()

    
    
    /**
     检测用户的登录状态，一旦发生改变就做出相应的动作
     */
    static func loginStateWatching(loginClosure: AuthClosure?,logoutClouser: MotionClouser?) {
        
        reference.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // 用户已认证
                loginClosure!(data: authData)
            } else {
                // 用户未认证
                logoutClouser!()
            }
        })
    }
    
    /**
     判断用户的登录状态并且做出相应的操作
     */
    static func loginStateJudge(loginClosure: AuthClosure?,logoutClouser: MotionClouser?) {
        
        if let authData = reference.authData {
            if (loginClosure != nil) { loginClosure!(data: authData) }
        }else {
            if (logoutClouser != nil) { logoutClouser!() }
        }
    }
    
    /**
     进行用户的登录操作
     */
    static func loginWithAccount(email: String,password: String,success: AuthClosure,fail: ErrorClosure) {
        
        reference.authUser(email, password: password) { (error, data) in
            
            if error != nil {
                fail(error: error)
                return
            }
            
            success(data: data)
        }
    }
    
    /**
     *	传入一个用户信息的字典，完成注册操作
     *  传入的Key:email -> 邮箱
     *           username -> 用户名
     *           password -> 密码
     *
     *	@since 0.1.0
     */
    
    static func registerWithUserInfo(info: [String: String],success: () -> (),fail: ErrorClosure) {
    
        reference.createUser(info[emailKey], password: info[pwdKey]) { (error, result) in
            
            if error != nil {
                fail(error: error)
            }else {
                
                let ext = [nameKey: info[nameKey]!]
                
                let uid = (result["uid"] as! NSString).substringFromIndex(12)
                
                reference.childByAppendingPath("users").childByAppendingPath(uid).setValue(ext)
                
                success()
            }
        }
    }
    
    

}
