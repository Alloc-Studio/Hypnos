//
//  BaseViewModelType.swift
//  Hypnos
//
//  Created by Maru on 16/5/24.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

protocol BaseViewModelType {
    
    associatedtype CellClass
    associatedtype ModelClass
    
    /// 数据源模型
    var source: [ModelClass] { get set }
    /// 更新UI事件
    var updateMotion: (() -> ())? { set get }
    
    /**
     数据->UI的绑定操作
     
     - parameter complete:	当完成拉取事件之后所采取的行动
     
     - returns: nil
     */
    func configSourceDidUpdate(complete: () -> ())
    
    /**
     更新Cell
     
     - parameter cell:	所需要更新的Cell
     - parameter index:	更新Cell的位置
    */
    func updateCell(cell: CellClass,AtIndex index: NSIndexPath)
    
    /**
     指定行的高度设定
     
     - parameter indexPath:	指定行
    
     */
    func heightForRow(indexPath: NSIndexPath) -> CGFloat
    
    /**
     Section header的高度
     */
    func heightForHeaderInSection(section: Int) -> CGFloat
}

extension BaseViewModelType {
    
    func heightForRow(indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func heightForHeaderInSection(section: Int) -> CGFloat {
        return 0
    }
}