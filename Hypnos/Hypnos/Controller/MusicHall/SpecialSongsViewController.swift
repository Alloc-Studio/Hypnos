//
//  SpecialSongsViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/27.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import SVProgressHUD

class SpecialSongsViewController: UIViewController {

    var playList:SpecialModel?
    var specialSongs:[HotSongsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(tableView)
        title = "\(playList!.title!)"
        SVProgressHUD.showWithStatus("正在拼命加载中...")
        DataTool.getSpecialSongs((playList?.id)!) { (obj) in
            self.specialSongs = (obj as! SpecialSongsModel).songs!
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBarHidden = false
        tabBarController?.tabBar.hidden = false
    }

    
    private lazy var tableView:UITableView = {
        let tb = UITableView(frame: self.view.bounds)
        tb.dataSource = self
        tb.delegate = self
        tb.tableFooterView = UIView()
        MusicListCell.registerCell(tb)
        return tb
    }()
    
    private lazy var musicPlayerVc:MusicPlayerController = {
        let vc:MusicPlayerController = MusicPlayerController()
        return vc
    }()
}

extension SpecialSongsViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return specialSongs.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(id_MusicListCell) as! MusicListCell
        cell.musicList = specialSongs[indexPath.row]
        cell.number.text = "\(indexPath.row+1)"
        return cell
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int  {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        Player.sharedPlayer().view.frame = view.bounds
        Player.sharedPlayer().musicModel = specialSongs[indexPath.row]
        Player.sharedPlayer().musics = specialSongs
        navigationController?.pushViewController(Player.sharedPlayer(), animated: true)
    }


    
}