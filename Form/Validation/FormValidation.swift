//
//  EntryValidation.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation

/**
 エラーバリデーションプロトコル
 */
protocol FormValidationType {
    
    /**
     エラーメッセージを保持するプロパティ
    */
    var errorMessage: String { get set }
    
    /**
     バリデーションチェック
     - parameter value: チェックする文字列
     - returns: エラーメッセージ
    */
    func validationCheck(value: String) -> String
}

// MARK: - 空文字のバリデーションチェック

/**
 空文字のバリデーションチェック
 */
class EmptyValidation: FormValidationType {
    
    var errorMessage: String
 
    func validationCheck(value: String) -> String {
        let errorMessage = value.isEmpty ? self.errorMessage : ""
        return errorMessage
    }
    
    // 初期化
    init(errorMessage: String = "入力してください") {
        self.errorMessage = errorMessage
    }
}

// MARK: -  MaxLengthエラーバリデーション

/**
 MaxLengthエラーバリデーション
 */
class LengthValidation: FormValidationType {
    
    /// バリデーションの文字数
    var maxLength: Int = 0
    
    /// Title
    var title: String = ""
    
    ///
    var errorMessage: String = ""
    
    init(title: String, maxLength: Int) {
        self.title = title
        self.maxLength = maxLength
    }
    
    func validationCheck(value: String) -> String {
        let isError = value.characters.count > maxLength
        errorMessage = isError ? "\(title)は\(maxLength)文字以内で入力してください" : ""
        return errorMessage
    }
}
