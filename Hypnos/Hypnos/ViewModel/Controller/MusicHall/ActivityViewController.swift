//
//  ActivityViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/27.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import SVProgressHUD

class ActivityViewController: UIViewController {
    
    private var activits:[ActivityModel] = []
    var artist:HotArtistsModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        SVProgressHUD.showWithStatus("正在拼命加载中...")
        DataTool.getArtistActivity((artist?.id)!) { (obj) in
            self.activits = (obj as! HotArtistsModel).events!
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private lazy var tableView:UITableView = {
        let tb = UITableView(frame: self.view.bounds)
        tb.dataSource = self
        tb.delegate = self
        tb.tableFooterView = UIView()
        ActivityCell.registerCell(tb)
        return tb
    }()
}

extension ActivityViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return activits.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(id_ActivityCell) as! ActivityCell
        cell.activitys = activits[indexPath.row]
        return cell
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return 1
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let web = WebViewController()
        web.activity = activits[indexPath.row]
        navigationController?.pushViewController(web, animated: true)
    }
    
}