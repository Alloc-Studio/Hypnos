//
//  MainViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/18.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //let revealVc:SWRevealViewController = revealViewController()
        
        addAllChildViewControllers()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //创建子控制器
    private  func addChildViewController(childController: UIViewController,imageName: String,titleName:String) {
        
        let vc = childController
        vc.title = titleName
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName+"_highlighted")
        
        let nav = UINavigationController(rootViewController: vc)
        addChildViewController(nav)
        
    }

    //添加子控制器
    private func addAllChildViewControllers() {
        addChildViewController(HomeViewController(), imageName: "tabbar_home", titleName: "首页")
        addChildViewController(RecommendViewController(), imageName: "tabbar_message_center", titleName: "推荐")
        addChildViewController(ProfileViewController(), imageName: "tabbar_profile", titleName: "我")
        
    }

}
