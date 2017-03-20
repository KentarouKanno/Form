//
//  CellDatatype.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation

/**
 セルに表示するデータプロトコル
 */
protocol CellDataType {
    
    /// セルのタイトル
    var title: String { get set }
    /// 表示する値
    var value: String { get set }
    /// バリデーションの結果
    var validationResult: ValidationResult { get set }
    
    /**
     バリデーションチェックを行う
    */
    func errorCheck()
    
    /**
     セルのタイトルを設定する
    */
    func setCellTitle(title: String)
    
}

/**
 CellDataTypeのデフォルト実装
 */
extension CellDataType {
    
    var title: String {
        get { return "" }
        set {}
    }
    
    var value: String {
        get { return "" }
        set {}
    }
    
    var validationResult: ValidationResult {
        get { return ValidationResult() }
        set {}
    }
    
    func errorCheck() {}
    
    func setCellTitle(title: String) {
        validationResult.title = title
    }
}
