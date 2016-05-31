//
//  HotSelectedViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/23.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

class HotSelectedViewController: UIViewController {

    
    var artists:[HotArtistsModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        DataTool.getHotArtistList { (obj) in
            let temp = obj as! [HotArtistsModel]
                for i in 0..<6 {
                    self.artists.append(temp[i])
              }
            self.view.addSubview(self.collectionView)
        }
        collectionView.alwaysBounceVertical = false
    }

    private lazy var collectionView:UICollectionView = {
        let layout                 = UICollectionViewFlowLayout()
        let collection             = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.whiteColor()
        collection.delegate        = self
        collection.dataSource      = self
        HotSelectedCell.registerCell(collection)
        return collection
    }()

}

extension HotSelectedViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
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
        vc.artist = artists[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
}