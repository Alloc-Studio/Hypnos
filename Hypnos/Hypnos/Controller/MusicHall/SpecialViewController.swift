//
//  SpecialViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/27.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import SVProgressHUD

class SpecialViewController: UIViewController {
    
    
    var artist:HotArtistsModel?
    var playList:[SpecialModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        SVProgressHUD.showWithStatus("正在拼命加载中...")
        
        DataTool.getSpecial((artist?.id)!) { (obj) in
            self.playList = (obj as! HotArtistsModel).playlist!
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private lazy var tableView:UITableView = {
        let tb = UITableView(frame: CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT - 48))
        tb.dataSource = self
        tb.delegate = self
        tb.tableFooterView = UIView()
        SpecialCell.registerCell(tb)
        return tb
    }()
}

extension SpecialViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return playList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(id_SpecialCell) as! SpecialCell
        cell.count.text = "\(indexPath.row + 1)"
        cell.special = playList[indexPath.row]
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sp = SpecialSongsViewController()
        sp.playList = playList[indexPath.row]
        navigationController?.pushViewController(sp, animated: true)
    }
    
}