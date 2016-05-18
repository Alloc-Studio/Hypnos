//
//  TELoginController.swift
//  TheOne
//
//  Created by Maru on 16/3/15.
//  Copyright © 2016年 Maru. All rights reserved.
//

import UIKit
import Cartography


class ProfileViewController: UITableViewController {
    
    /// 头视图
    let headerView = UIView()
    /// 姓名标签
    let nameTips = UILabel()
    /// 登录按钮
    var loginButton: UIButton!
    
    private let headerView_H: CGFloat = 200.0
    
    
    var headerImageView: UIImageView!
    
    // MARK: - Initialilzer
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupHeader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        setupHeader()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    // MARK: - Private Method
    private func setupHeader() {
        
        navigationController?.navigationBar.hidden = true

        headerView.frame = CGRectMake(0, 0, 0, headerView_H)
        headerImageView = UIImageView(image: UIImage(named: "profile_background"))
        headerImageView.frame = CGRectMake(0, 0, SCREEN_BOUNDS.width, headerView_H)
        headerImageView.userInteractionEnabled = true
        headerView.addSubview(headerImageView)
        
        loginButton = UIButton(type: .Custom)
        loginButton.setImage(UIImage(named: "personal"), forState: .Normal)
        headerImageView.addSubview(loginButton)
        
        nameTips.textColor = UIColor.whiteColor()
        nameTips.font = UIFont.systemFontOfSize(14)
        nameTips.text = "请登录"
        headerImageView.addSubview(nameTips)
        
        tableView.tableHeaderView = headerView
        
        // Layout View
        constrain(loginButton,nameTips) { loginButton,nameTips in
            
            loginButton.width == 50
            loginButton.height == 50
            loginButton.centerX == loginButton.superview!.centerX
            loginButton.centerY == loginButton.superview!.centerY
            
            nameTips.top == loginButton.bottom
            nameTips.height == 30
            nameTips.centerX == loginButton.centerX
            
        }
        
        // Add Event
        loginButton.addTarget(self, action: #selector(presentToLoginController), forControlEvents: .TouchUpInside)
    }
    
    
    // MARK: - Private method

    
    func presentToLoginController() {
        
    }
    
    
    // MARK: - UIScrolView Delegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset_y = scrollView.contentOffset.y
        
        guard offset_y < 0 else {
            return
        }
        
        headerImageView.frame = CGRectMake(0, offset_y, SCREEN_BOUNDS.width, headerView_H - offset_y)
        
    }
    
    // MARK: - UITableView Delegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = "其他设置"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}