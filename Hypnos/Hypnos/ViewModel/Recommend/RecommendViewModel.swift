//
//  RecommendViewModel.swift
//  Hypnos
//
//  Created by Maru on 16/5/24.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModelType {
    
    typealias CellClass = MusicListCell
    typealias ModelClass = HotSongsModel
    
    var updateMotion: (() -> ())?
    var source: [ModelClass] {
        didSet {
            if let motion = updateMotion {
                motion()
            }
        }
    }
    
    init() {
        source = []
    }
    
    func configSourceDidUpdate(complete: () -> ()) {
        updateMotion = complete
    }
    
    func updateCell(cell: CellClass,AtIndex index: NSIndexPath) {
        cell.number.text = String(source[index.row].rank!)
        cell.musicList = source[index.row]
    }
    
    func fetchLatestData(beginFetch: () -> ()?) {
        beginFetch()
        DataTool.getHotSongList { [unowned self] (obj) in
            let array = obj as! NSArray
            var temp = [ModelClass]()
            array.enumerateObjectsUsingBlock({ (obj, index, bool) in
                temp.append(obj as! ModelClass)
            })
            self.source = temp
        }
    }
    
    func heightForRow(indexPath: NSIndexPath) -> CGFloat {
        return 56.0
    }
    
    func heightForHeaderInSection(section: Int) -> CGFloat {
        return 100
    }
}
