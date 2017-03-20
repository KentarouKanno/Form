//
//  CellViewModelType.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation
import UIKit

protocol CellViewModelType {
    
    var cellData: CellDataType! { get set }
    func createCell(indexPath: IndexPath) -> UITableViewCell
    func cellReload()
}

extension CellViewModelType {
    
    var cellData: CellDataType! {
        return nil
    }
    
    func createCell(indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func cellReload() {}
}
