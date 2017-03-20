//
//  ValidationResult.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation


/**
 バリデーションチェックを行った結果クラス
 */
class ValidationResult {
    
    var title: String = ""
    var errorMessage: String = ""
    
    /**
     エラーがあるかどうかを判定して返す
     - returns: true: エラーあり, false: エラー無し
    */
    func isError() -> Bool {
        return errorMessage.isEmpty ? false : true
    }
    
    /**
     エラーメッセージをリセットする
    */
    func resetError() {
        errorMessage = ""
    }
    
    /**
     エラーメッセジを設定する
     - parameter errorMessage: 設定する文字列
    */
    func setMessage(errorMessage: String) {
        self.errorMessage = errorMessage
    }
    
    /**
     Formatを決めた文字列を返す(title:errorMessage)
     - returns: Format文字列
    */
    func createFormatString() -> String? {
        if !title.isEmpty && !errorMessage.isEmpty {
            return title + ":" + errorMessage
        }
        return nil
    }
}
