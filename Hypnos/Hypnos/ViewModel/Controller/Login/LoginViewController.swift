//
//  LoginViewController.swift
//  Hypnos
//
//  Created by Maru on 16/5/19.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import SVProgressHUD
import JLToast

class LoginViewController: UIViewController {
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        setupUI()
        
        setupSetting()
    }

    
    @IBOutlet weak var account: LoginTextFiled!
    @IBOutlet weak var password: LoginTextFiled!
    
    // MARK: - Motion
    
    @IBAction func registerClick(sender: AnyObject) {
        
        let registerVC = UIStoryboard.customInstanceViewController(.Independence, cls: RegisterViewController.self) as! RegisterViewController
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    // MARK: - Private Method
    private func setupUI() {
        
    }
    
    private func setupSetting() {
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.keyboardDismiss)))
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardFrameWillChange(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
    }
    
    
    @objc private func keyboardDismiss() {
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
    }
    
    func keyboardFrameWillChange(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as?
            UInt
            
            let changeFrame = value?.CGRectValue()
            
            UIView.animateWithDuration(duration!, delay: 0, options: UIViewAnimationOptions(rawValue: curve!), animations: {
                
                self.view.frame = CGRectMake(0, (changeFrame?.origin.y)! - self.view.frame.height, self.view.frame.width, self.view.frame.height)
                
                }, completion: nil)
            
        }
    }
    
    
    @IBAction func loginMotion(sender: UIButton) {
        
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
        
        SVProgressHUD.show()
        
        WilddogService.loginWithAccount(account.text!, password: password.text!, success: { (data) in
            SVProgressHUD.dismiss()
            self.dismissViewControllerAnimated(true, completion: nil)
            }) { (error) in
                SVProgressHUD.dismiss()
                JLToast.makeText("账号或者密码错误!").show()
        }
        
    }
    
    


}
