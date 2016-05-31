//
//  ActivityCell.swift
//  Hypnos
//
//  Created by Fay on 16/5/27.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

let id_ActivityCell = "ActivityCell"
class ActivityCell: UITableViewCell {

    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var abstract: UILabel!
    
    
    var activitys:ActivityModel? {
        didSet {
            day.text = "\(activitys!.day!)"
            month.text = "\(activitys!.month!) 月"
            picture.kf_setImageWithURL((activitys?.icon?.url)!)
            title.text = activitys?.title
            abstract.text = activitys?.abstract
            
        }

    }
    
    class func registerCell(tableView:UITableView) {
        let nib = UINib(nibName: id_ActivityCell, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: id_ActivityCell)
        
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
