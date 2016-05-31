//
//  SpecialCell.swift
//  Hypnos
//
//  Created by Fay on 16/5/27.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

let id_SpecialCell = "SpecialCell"

class SpecialCell: UITableViewCell {

    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var specialName: UILabel!
    
    var special:SpecialModel? {
        didSet{
            specialName.text = special?.title
        }
    }
    
    
    class func registerCell(tableView:UITableView) {
        let nib = UINib(nibName: id_SpecialCell, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: id_SpecialCell)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {

    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        
    }
    
}
