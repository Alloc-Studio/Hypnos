//
//  UIKit+Hypnos.swift
//  Hypnos
//
//  Created by Maru on 16/5/19.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

enum HYStoryType: String {
    case Main = "Main"
    case Independence = "Independence"
}


extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
}

extension UIViewController {
    
}

extension UIStoryboard {
    
    static func customInstanceViewController(type: HYStoryType,cls: AnyObject.Type) -> AnyObject? {
        
        return UIStoryboard(name: type.rawValue, bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier(String(cls))
    }
}

extension UINavigationBar {
    
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.hidden = true
    }
    
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.hidden = false
    }
    
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view.isKindOfClass(UIImageView) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}

extension UIViewController {
    
    func showActionSheetAlert(title: String,message: String,doSomething: () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
        let confirm = UIAlertAction(title: "确定", style: .Destructive) { (action) in
            doSomething()
        }

        let concel = UIAlertAction(title: "取消", style: .Cancel) { (action) in
            
        }
        
        alert.addAction(confirm)
        alert.addAction(concel)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
}

extension UITableView {
    /**
     当数据源为空时，显示的方式
     
     - parameter message: 提示内容
     - parameter count:   数据数组数量
     */
    func tableViewDisplay(emptyMessage message: String,count: NSInteger) {
        guard count == 0 else {
            backgroundView = nil
            separatorStyle = .SingleLine
            return
        }
        
        let lable = UILabel()
        lable.text = message
        lable.textColor = UIColor.lightGrayColor()
        lable.textAlignment = .Center
        backgroundView = lable
        separatorStyle = .None
        
    }
    
}

extension UIView {
    var x: CGFloat {
        get { return self.frame.origin.x }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    var y: CGFloat {
        get { return self.frame.origin.y }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    var width: CGFloat {
        get { return self.frame.size.width }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    var height: CGFloat {
        get { return self.frame.size.height }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    var top: CGFloat {
        get { return self.y }
        set { self.y = newValue }
    }
    var bottom: CGFloat {
        get { return self.y + self.height }
        set { self.y = newValue - self.height }
    }
    var left: CGFloat {
        get { return self.x }
        set { self.x = newValue }
    }
    var right: CGFloat {
        get { return self.x + self.width }
        set { self.x = newValue - self.width }
    }
}
