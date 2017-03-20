//
//  CellValidation.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation


/**
 TextFieldセルに対するバリデーションを返すクラス
 */
struct TextFieldErrorValidations {
    
    static func validations() -> [FormValidationType] {
        
        // 空文字チェック
        let emptyValidation = EmptyValidation()
        
        // MaxLengthチェック
        let lengthValidation = LengthValidation(title: "氏名", maxLength: 3)
        
        return [emptyValidation, lengthValidation]
    }
}

/**
 DatePickerTextFieldセルに対するバリデーションを返すクラス
 */
struct DatePickerTextFieldErrorValidations {
    
    static func validations() -> [FormValidationType] {
        
        // 空文字チェック
        let emptyValidation = EmptyValidation()
        
        return [emptyValidation]
    }
}


/**
 PickerTextFieldセルに対するバリデーションを返すクラス
 */
struct PickerTextFieldErrorValidations {
    
    static func validations() -> [FormValidationType] {
        
        // 空文字チェック
        let emptyValidation = EmptyValidation()
        
        return [emptyValidation]
    }
}


/**
 TwoCulumnPickerTextFieldセルに対するバリデーションを返すクラス
 */
struct TwoColumnPickerTextFieldErrorValidations {
    
    static func validations() -> [FormValidationType] {
        
        // 空文字チェック
        let emptyValidation = EmptyValidation()
        
        return [emptyValidation]
    }
}

/**
 TextViewセルに対するバリデーションを返すクラス
 */
struct TextViewErrorValidations {
    
    static func validations() -> [FormValidationType] {
        
        // 空文字チェック
        let emptyValidation = EmptyValidation()
        
        // MaxLengthチェック
        let lengthValidation = LengthValidation(title: "質問", maxLength: 20)
        
        return [emptyValidation, lengthValidation]
    }
}



