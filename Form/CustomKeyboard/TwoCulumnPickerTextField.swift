//
//  TwoCulumnPickerTextField.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation
import UIKit


/// TwoColumnPickerTextFieldDelegate
@objc
protocol TwoColumnPickerTextFieldDelegate: class {
    
    /**
     Doneボタン押下
     - parameters textField: TwoColumnPickerTextField
     - parameters text:
     */
    @objc optional func donePressed(textField: TwoColumnPickerTextField, text: String)
    
    /**
     Cancelボタン押下
     - parameters textField: TwoColumnPickerTextField
     */
    @objc optional func cancelPressed(textField: TwoColumnPickerTextField)
}


/**
 ToolBar付き2ColumnPickerTextField
 */
class TwoColumnPickerTextField: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// Delegate
    weak var twoColumnPickerDelegate: TwoColumnPickerTextFieldDelegate?
    
    let pickerView = UIPickerView()
    let toolbarHeight: CGFloat = 44
    
    var yearArray = (1940...2017).map{ String($0) }
    var monthArray = (1...12).map{ String($0) }
    
    var selectYear = ""
    var selectMonth = ""
    
    var defalutValue = "197401"
    
    var isSetDefaultText = false
    
    var defaultText: String! {
        get { return "" }
        set(value) {
            
            guard var valueText = value else {
                return
            }
            
            if value.characters.count != 6 {
                
                if isSetDefaultText {
                    return
                }
                
                valueText = defalutValue
                isSetDefaultText = true
                setDefaultValue(valueText: valueText, setText: false)
                
            } else {
                
                setDefaultValue(valueText: valueText, setText: true)
            }
        }
    }
    
    func setDefaultValue(valueText: String, setText: Bool) {
        
        let year = valueText.substring(to: valueText.index(valueText.startIndex, offsetBy: 4))
        guard let intMonth = Int(valueText.substring(from: valueText.index(valueText.startIndex, offsetBy: 4))) else {
            return
        }
        
        let month = String(intMonth)
        
        if let yearIndex = yearArray.index(of: year),
            let monthIndex = monthArray.index(of: month) {
            
            pickerView.selectRow(yearIndex, inComponent: 0, animated: false)
            pickerView.selectRow(monthIndex, inComponent: 1, animated: false)
            
        } else {
            pickerView.selectRow(0, inComponent: 0, animated: false)
            pickerView.selectRow(0, inComponent: 1, animated: false)
        }
        selectYear = year
        selectMonth = String(format: "%02d", Int(month) ?? 1)
        
        if setText {
            self.text = selectYear + "年" + month + "月"
        }
    }
    
    /**
     初期化
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.tintColor = .clear
        pickerView.delegate = self
        pickerView.dataSource = self
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
            pickerView.frame = CGRect(x: 0,
                                      y: toolbarHeight,
                                      width: UIScreen.main.bounds.width,
                                      height: pickerView.bounds.height)
            pickerView.delegate   = self
            pickerView.dataSource = self
            pickerView.backgroundColor = .white
            return pickerView
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
     Doneボタン押下時処理
     */
    func donePressed() {
        
        let month = monthArray[pickerView.selectedRow(inComponent: 1)]
        self.text = selectYear + "年" + month + "月"
        twoColumnPickerDelegate?.donePressed?(textField: self, text: selectYear + selectMonth)
        
        resignFirstResponder()
    }
    
    /**
     Cancelボタン押下時処理
     */
    func cancelPressed() {
        
        twoColumnPickerDelegate?.cancelPressed?(textField: self)
        resignFirstResponder()
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    // 表示行
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0 : return yearArray.count
        case 1 : return monthArray.count
        default: return 0
        }
    }
    
    // MARK: - UIPickerViewDelegate
    
    // 各ラベルの幅
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        
        switch component {
        case 0 : return screenWidth / 2
        case 1 : return screenWidth / 2
        default: return 0
        }
    }
    
    //表示内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0 : return yearArray[row] + "年"
        case 1 : return monthArray[row] + "月"
        default: return nil
        }
    }
    
    //選択時
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0 : selectYear = yearArray[row]
        case 1 : selectMonth =  String(format: "%02d", Int(monthArray[row]) ?? 1)
        default: break
        }
    }
}
