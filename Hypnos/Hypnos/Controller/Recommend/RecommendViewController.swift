//
//  RecommendViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/18.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class RecommendViewController: UITableViewController {
    
    var banner: RecommendBanner!
    var unloginView: UnloginView!
    
    var viewModel = RecommendViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        setupSetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
        tabBarController?.tabBar.hidden = false
    }
    
    // MARK: -  Private Method
    private func setupUI() {
        
        presentMusicItem()

        banner = NSBundle.mainBundle().loadNibNamed(String(RecommendBanner), owner: nil, options: nil).first as! RecommendBanner
        unloginView = NSBundle.mainBundle().loadNibNamed(String(UnloginView), owner: self, options: nil).first as! UnloginView
        
        WilddogService.loginStateWatching({ [unowned self] (data) in
            self.unloginView.removeFromSuperview()
            self.view.userInteractionEnabled = true
            self.viewModel.fetchLatestData { () -> ()? in
                dispatch_async(dispatch_get_main_queue(), {
                    SVProgressHUD.showWithStatus("正在拉取数据...")
                })
            }
        }) {
            self.view.addSubview(self.unloginView)
        }
        
        navigationController?.navigationBar.hideBottomHairline()
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
    
    }
    
    private func setupSetting() {
        
        unloginView.loginMotion = { [unowned self] in
            
            let loginVC = UIStoryboard.customInstanceViewController(.Independence, cls: LoginViewController.self) as! LoginViewController
            self.presentViewController(UINavigationController(rootViewController: loginVC), animated: true, completion: nil)
        }
        
        tableView.registerNib(UINib(nibName: String(MusicListCell),bundle: nil), forCellReuseIdentifier: String(MusicListCell))
        
        viewModel.configSourceDidUpdate { [unowned self] in
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
        
    }
    
    private lazy var musicPlayerVc:MusicPlayerController = {
        let vc:MusicPlayerController = MusicPlayerController()
        return vc
    }()
    
}

extension RecommendViewController {
    
    // MARK: - Data Source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tableViewDisplay(emptyMessage: "对不起，暂时没有数据哦~", count: viewModel.source.count)
        return viewModel.source.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(String(MusicListCell), forIndexPath: indexPath) as! MusicListCell
        
        viewModel.updateCell(cell, AtIndex: indexPath)
        
        return cell
    }
    
    
    // MARK: - Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        musicPlayerVc.view.frame = view.bounds
        musicPlayerVc.musicModel = viewModel.source[indexPath.row]
        musicPlayerVc.musics = viewModel.source
        navigationController?.pushViewController(musicPlayerVc, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderInSection(section)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return banner
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel.heightForRow(indexPath)
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension RecommendViewController: MCItemPresentable {
    
    func showMuicController() {
        guard let _ = Player.sharedPlayer().musicModel else {
            SweetAlert().showAlert("亲~", subTitle: "您还没有选择歌曲哦~~~", style: AlertStyle.CustomImag(imageFile: "recommend_cry"))
            return
        }
        navigationController?.pushViewController(Player.sharedPlayer(), animated: true)
    }
}