//
//  MusicHallViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/23.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class MusicHallViewController: UIViewController {

    var songs:[HotSongsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        SVProgressHUD.showWithStatus("正在玩命加载中...")
        DataTool.getHotSongList { (obj) in
            self.songs = obj as![HotSongsModel]
            self.tableView.reloadData()
            self.tableView.frame.size.height = self.tableView.contentSize.height
            SVProgressHUD.dismiss()
            self.view.addSubview(self.tableView)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private lazy var tableView:UITableView = {
        let tv: UITableView = UITableView(frame:self.view.bounds)
        tv.tableFooterView = UIView()
        tv.delegate = self
        tv.dataSource = self
        MusicListCell.registerCell(tv)
        return tv
    }()
    
    private lazy var musicPlayerVc:MusicPlayerController = {
        let vc:MusicPlayerController = MusicPlayerController()
        return vc
    }()
    
}

extension MusicHallViewController:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return songs.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(id_MusicListCell) as! MusicListCell
        cell.number.text = "\(indexPath.row + 1) "
        cell.musicList = songs[indexPath.row]
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        Player.sharedPlayer().view.frame = view.bounds
        Player.sharedPlayer().musicModel = songs[indexPath.row]
        Player.sharedPlayer().musics = songs
        navigationController?.pushViewController(Player.sharedPlayer(), animated: true)
    }
    
}

