//
//  RegisterViewController.swift
//  Hypnos
//
//  Created by Maru on 16/5/22.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import JLToast


class RegisterViewController: UIViewController {
    
    @IBOutlet weak var email: LoginTextFiled!
    @IBOutlet weak var username: LoginTextFiled!
    @IBOutlet weak var password: LoginTextFiled!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Motion
    
    @IBAction func registerUser(sender: UIButton) {
        
        UIApplication.sharedApplication().keyWindow?.endEditing(true)
        
        let info = [
            WilddogService.emailKey: email.text!,
            WilddogService.pwdKey: password.text!,
            WilddogService.nameKey: username.text!
        ]
        
        WilddogService
            .registerWithUserInfo(info, success: { (data) in
                self.navigationController?.popViewControllerAnimated(true)
            }) { (error) in
                JLToast.makeText("注册失败，请检查邮箱！").show()
        }
    }
    
    // MARK: - Private Method
    private func setupUI() {
        
    }
    
    func setupSetting() {
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.keyboardDismiss)))
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RegisterViewController.keyboardFrameWillChange), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    func keyboardDismiss() {
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

}
