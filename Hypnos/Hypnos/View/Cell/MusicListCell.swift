//
//  MusicListCell.swift
//  Hypnos
//
//  Created by Fay on 16/5/20.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import Kingfisher

let id_MusicListCell = "MusicListCell"
class MusicListCell: UITableViewCell {
        
    @IBOutlet private weak var musicName: UILabel!
    @IBOutlet private weak var artist: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet private weak var favoriteBtn: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
    override func awakeFromNib() {
        contentView.removeFromSuperview()
    }
    

    class func registerCell(tableView:UITableView) {
        let nib = UINib(nibName: id_MusicListCell, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: id_MusicListCell)
    }
    
    var musicList:HotSongsModel? {
        didSet {
            self.musicName.text = musicList!.name
            self.artist.text = musicList!.artist
        }
    }
    
    @IBAction func favoriteClick(sender: AnyObject) {
        
        self.favoriteBtn.selected = !self.favoriteBtn.selected
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        
    }
    
}
