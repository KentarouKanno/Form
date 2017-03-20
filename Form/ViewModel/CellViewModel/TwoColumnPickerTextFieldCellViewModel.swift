//
//  TwoColumnPickerTextFieldCellViewModel.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation
import UIKit

/**
 TwoColumnDatePickerTextFieldCellのViewModel
 */
class TwoColumnPickerTextFieldCellViewModel: CellViewModelType, TwoColumnPickerTextFieldCellDelegate {
    
    /// セルに表示するデータ
    var cellData: CellDataType!
    /// テーブル
    var tableView: UITableView!
    /// セルのIndexPath
    var indexPath: IndexPath!
    /// BaseのViewController
    var viewController: UIViewController!
    
    /**
     初期化
     - parameter cellData: セルに表示するデータ
     - parameter tableView: テーブル
     */
    init<vc: UIViewController>(viewController: vc, cellData: CellDataType) where vc: FormViewControllerType  {
        
        self.cellData = cellData
        self.tableView = viewController.table
        self.viewController = viewController
        tableView.register(UINib(nibName: "TwoColumnPickerTextFieldCell", bundle: nil), forCellReuseIdentifier: "TwoColumnPickerTextFieldCell")
    }
    
    /**
     セルを返す
     - parameter indexPath: セルのIndexPath
     - returns: 生成したUITableViewCell
     */
    func createCell(indexPath: IndexPath) -> UITableViewCell {
        
        // セルのIndexPathを保持
        self.indexPath = indexPath
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TwoColumnPickerTextFieldCell", for: indexPath) as? TwoColumnPickerTextFieldCell,
            let cellData = cellData as? TwoColumnPickerTextFieldCellData {
            cell.cellData = cellData
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    /**
     セルのリロード
     */
    func cellReload() {
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
