//
//  DatePickerTextFieldCellData.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation

/**
 DatePickerTextFieldCellのデータ
 */
class DatePickerTextFieldCellData: CellDataType {
    
    /// タイトル
    var title: String = ""
    /// プレースホルダ
    var placeholder: String = ""
    /// 必須フラグ
    var isRequired: Bool = false
    /// 入力文字列
    var value: String = ""
    /// バリデーションの結果
    var validationResult: ValidationResult = ValidationResult()
    /// バリデーション配列
    var validations: [FormValidationType] = []
    
    /**
     初期化
     */
    init(title: String = "",
         placeholder: String = "",
         required: Bool = false,
         value: String = "",
         validations: [FormValidationType] = []) {
        
        self.title = title
        self.placeholder = placeholder
        self.isRequired = required
        self.value = value
        self.validations = validations
        setCellTitle(title: title)
    }
    
    /**
     エラーチェックメソッド
     */
    func errorCheck() {
        
        // エラーメッセージをリセット
        validationResult.resetError()
        
        // 順にバリデーションを適用する
        for validation in validations {
            
            if !validationResult.isError() {
                // エラーがある場合メッセージをvalidationResultに設定する
                validationResult.setMessage(errorMessage: validation.validationCheck(value: value))
            }
        }
    }
}
