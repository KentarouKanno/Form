//
//  DatePickerTextField.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation
import UIKit

/**
 DatePickerTextFieldDelegate
 */
@objc
protocol DatePickerTextFieldDelegate: class  {
    /**
     Doneボタン押下
     - parameters textField: CustomTextField
     - parameters dateString: yyyyMMddでフォーマットされた文字列(例: 19851128)
     */
    @objc optional func donePressed(textField: DatePickerTextField, dateString: String)
    
    /**
     Cancelボタン押下
     - parameters textField: CustomTextField
     */
    @objc optional func cancelPressed(textField: DatePickerTextField)
}

/**
 Toolbar付きDatePickerTextFieldクラス
 */
class DatePickerTextField: UITextField {
    
    /// Delegate
    weak var datePickerDelegate: DatePickerTextFieldDelegate?
    
    let datePicker = UIDatePicker()
    var datePickerMode: UIDatePickerMode = .date
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.tintColor = .clear
    }
    
    /**
     DatePickerの値を設定、TextFieldの文字も同時に設定
     - parameters dateString: yyyyMMddでフォーマットされた文字列(例: 19851128)
    */
    func setDatePicker(dateString: String) {
        
        guard dateString.utf16.count == 8 else {
            return
        }
        
        // dateString 19851128 → 1985年11月28日
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyyMMdd"
        
        if let date = formatter.date(from: dateString) {
            datePicker.date = date
            setTextFieldDateString()
        }
    }
    
    func setDefaultDate(dateString: String) {
        
        // dateString 19851128 → 1985年11月28日
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyyMMdd"
        
        if let date = formatter.date(from: dateString) {
            datePicker.date = date
        }
    }
    
    override var inputAccessoryView: UIView? {
        get {
            
            /// ToolBar
            let toolBar = UIToolbar()
            toolBar.barStyle = .default
            toolBar.isTranslucent = true
            toolBar.tintColor = .black
            
            /// Done Button
            let doneButton   = UIBarButtonItem(title: "Done",
                                               style: .done,
                                               target: self,
                                               action: #selector(self.donePressed))
            /// Cancel Button
            let cancelButton = UIBarButtonItem(title: "Cancel",
                                               style: .plain,
                                               target: self,
                                               action: #selector(self.cancelPressed))
            /// Spacing
            let spaceButton  = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                               target: nil,
                                               action: nil)
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            toolBar.sizeToFit()
            
            return toolBar
        }
        set {}
    }
    
    override var inputView: UIView? {
        get {
            /// Create DatePicker
            datePicker.frame = CGRect(x: 0,
                                      y: 44,
                                      width: UIScreen.main.bounds.width,
                                      height: datePicker.bounds.height)
            datePicker.datePickerMode = datePickerMode
            datePicker.backgroundColor = .white
            return datePicker
        }
        set {}
    }
    
    // 入力カーソル非表示
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    // 範囲選択カーソル非表示
    override func selectionRects(for range: UITextRange) -> [Any] {
        return []
    }
    
    // コピー・ペースト・選択等のメニュー非表示
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    /**
     テキストフィールドにPickerで選択した文字列を反映する
     */
    func setTextFieldDateString() {
        
        // Format 1985年11月28日
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let dateStr = formatter.string(from: datePicker.date)
        self.text = dateStr
    }
    
    /**
     Doneボタン押下時処理
     */
    func donePressed(){
        
        setTextFieldDateString()
        
        // Format 19851128
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let dateStr = formatter.string(from: datePicker.date)
        datePickerDelegate?.donePressed?(textField: self, dateString: dateStr)
        
        resignFirstResponder()
    }
    
    /**
     Cancelボタン押下時処理
     */
    func cancelPressed(){
        datePickerDelegate?.cancelPressed?(textField: self)
        resignFirstResponder()
    }
}
