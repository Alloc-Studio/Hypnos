//
//  HttpTool.swift
//  Hypnos
//
//  Created by Fay on 16/5/19.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HttpTool: NSObject {

    
    class func getDataList(url:String,parameters:[String:AnyObject]?=nil,failCallback:(NSError)->Void,successCallback:(JSON)->Void) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Alamofire.request(.GET, url, parameters: parameters).responseData { (response) in
            
            if let returnStr = response.result.value {
            let range = NSRange(location: 27, length: (response.result.value?.length)! - 29)
            let data = returnStr.subdataWithRange(range)
            let json = JSON(data: data)

               successCallback(json)
            }else if let error = response.result.error {
                failCallback(error)
            }
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
}
