//
//  MoreArtistsViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/24.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import SVProgressHUD

class MoreArtistsViewController: UIViewController {
    
    
    var artists:[HotArtistsModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        title = "热门歌手"
        SVProgressHUD.showWithStatus("正在拼命加载中...")
        DataTool.getHotArtistList { (obj) in
            self.artists = obj as! [HotArtistsModel]
            self.view.addSubview(self.collectionView)
            self.collectionView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    private lazy var collectionView:UICollectionView = {
        let layout                 = UICollectionViewFlowLayout()
        let collection             = UICollectionView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-108), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.whiteColor()
        collection.delegate        = self
        collection.dataSource      = self
        HotSelectedCell.registerCell(collection)
        return collection
    }()
    
}

extension MoreArtistsViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return artists.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 140)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(15, 15, 5, 15)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HotSelectedCell_id, forIndexPath: indexPath) as! HotSelectedCell
        
        cell.hotArtist = artists[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let vc = ArtistDetailViewController()
        vc.artist = artists[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}