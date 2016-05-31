//
//  HotSelectedCell.swift
//  Hypnos
//
//  Created by Fay on 16/5/23.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

let HotSelectedCell_id = "HotSelectedCell"

class HotSelectedCell: UICollectionViewCell {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var style: UILabel!
    
    var hotArtist:HotArtistsModel? {
        didSet {
            picture.kf_setImageWithURL((hotArtist?.picture?.url)!)
            name.text = hotArtist?.name
            style.text = hotArtist?.style
        }
        
    }
    
    class func registerCell(collectionView:UICollectionView) {
        let nib = UINib(nibName: HotSelectedCell_id, bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: HotSelectedCell_id)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
