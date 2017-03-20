//
//  PickerDataArrayType.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation


/**
 PickerDataのModelType
 */
protocol PickerDataArrayType {
    
    /// コード
    var code: String { get set }
    /// タイトル
    var title: String { get set }
}

/**
 PickerData Model
 */
class PickerData: PickerDataArrayType {
    
    var code: String
    var title: String
    
    // 初期化
    init(code: String, title: String) {
        self.code = code
        self.title = title
    }
}

/**
 PickerDataの配列を扱うクラス
 */
class PickerDataArray {
    
    // PickerDataの配列
    var array: [PickerDataArrayType] = []
    
    // 初期化
    init(array: [PickerDataArrayType]) {
        self.array = array
    }
    
    /**
     Pickerに表示する文字列配列を返す
    */
    var pickerStringArray: [String] {
        return array.map { $0.title }
    }
    
    /**
     値から配列のIndexを返す、一致しない場合はnilを返す
     - parameters value: 検索する値
    */
    func index(value: String) -> Int? {
        
        for item in array.enumerated() {
            if item.element.code == value {
                return item.offset
            }
        }
        return nil
    }
    
    /**
     値から一致したPickerのタイトルを返す、一致しない場合はnilを返す
     - parameters value: 検索する値
    */
    func text(from value: String) -> String? {
        
        for item in array.enumerated() {
            if item.element.code == value {
                return item.element.title
            }
        }
        return nil
    }
    
    /**
     選択したテキストから一致したコードを返す、未選択・一致しない場合は空文字を返す
     - prameters value: 検索する値
    */
    func picker(text: String) -> String {
        
        for item in array.enumerated() {
            if item.element.title == text {
                if item.offset == 0 && item.element.title == "選択してください" {
                    return ""
                }
                return item.element.code
            }
        }
        return ""
    }
}
