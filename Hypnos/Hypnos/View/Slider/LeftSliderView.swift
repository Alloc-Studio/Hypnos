//
//  LeftSliderView.swift
//  Hypnos
//
//  Created by Maru on 16/5/26.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

class LeftSliderView: UIView {

    @IBOutlet weak var header: UIImageView!
    @IBOutlet weak var username: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    

    override func awakeFromNib() {
        header.layer.cornerRadius = 35
        header.layer.masksToBounds = true
        tableView.registerClass(LeftSliderCell.self, forCellReuseIdentifier: String(LeftSliderCell))
        tableView.separatorStyle = .None
    }
}

extension LeftSliderView: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(LeftSliderCell), forIndexPath: indexPath) as! LeftSliderCell
        switch indexPath.row {
        case 0:
            cell.icon.image = UIImage(named: "slide-collect")
            cell.title.text = "我的收藏"
            break
        case 1:
            cell.icon.image = UIImage(named: "slide-record")
            cell.title.text = "播放记录"
            break
        case 2:
            cell.icon.image = UIImage(named: "slide-skin")
            cell.title.text = "主题换肤"
            break
        default: break
        }
        
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let btn = UIButton()
        btn.setTitle("dsadsadsa", forState: .Normal)
        return UIButton()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    
    
    
}
