
//
//  ArtistListCell.swift
//  Hypnos
//
//  Created by Fay on 16/5/20.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

let id_ArtistListCell = "ArtistListCell"
class ArtistListCell: UITableViewCell {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var follower: UILabel!
    
    
    class func registerCell(tableView:UITableView) {

        let nib = UINib(nibName: id_ArtistListCell, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: id_ArtistListCell)
    }
    
    
    var artists:HotArtistsModel? {
        didSet{
            
            picture.kf_setImageWithURL(artists!.picture!.url)
            artistName.text = artists?.name
            type.text = artists!.style
            follower.text = "\(artists!.follower!)人关注"

        }
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        
    }
}
