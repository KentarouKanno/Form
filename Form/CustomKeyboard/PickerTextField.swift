//
//  PickerTextField.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//


import Foundation
import UIKit

/**
 PickerTextFieldDelegate
 */
@objc
protocol PickerTextFieldDelegate: class {
    
    /**
     Doneボタン押下
     - parameters textField: PickerTextField
     - parameters text: 選択した文字列
     */
    @objc optional func donePressed(textField: PickerTextField, text: String)
    
    /**
     Cancelボタン押下
     - parameters textField: PickerTextField
     */
    @objc optional func cancelPressed(textField: PickerTextField)
}

/**
 Toolbar付きPickerTextFieldクラス
 */
class PickerTextField: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// Delegate
    weak var pickerTextFieldDelegate: PickerTextFieldDelegate?
    
    private let pickerView = UIPickerView()
    private let toolbarHeight: CGFloat = 44
    
    /// Pickerに表示する配列
    var pickerDataArray = [String]() {
        didSet {
            if let selectText = pickerDataArray.first {
                self.selectText = selectText
            }
        }
    }
    
    private var selectText: String = ""
    
    /// PickerViewの表示時に選択されている項目を設定する
    var defaultText: String! {
        get { return "" }
        set {
            if let selectIndex = pickerDataArray.index(of: newValue) {
                pickerView.selectRow(selectIndex, inComponent: 0, animated: false)
            } else {
                pickerView.selectRow(0, inComponent: 0, animated: false)
            }
            self.text = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.tintColor = .clear
        pickerView.delegate   = self
        pickerView.dataSource = self
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
    
    override var inputAccessoryView: UIView? {
        get {
            
            /// ToolBar
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor.black
            
            /// Done Button
            let doneButton = UIBarButtonItem(title: "Done",
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
            pickerView.backgroundColor = .white
            return pickerView
        }
        set {}
    }
    
    /**
     Doneボタン押下時処理
     */
    @objc private func donePressed() {
        self.text = selectText
        pickerTextFieldDelegate?.donePressed?(textField: self, text: selectText)
        resignFirstResponder()
    }
    
    /**
     Cancelボタン押下時処理
     */
    @objc private func cancelPressed() {
        pickerTextFieldDelegate?.cancelPressed?(textField: self)
        resignFirstResponder()
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataArray.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectText = pickerDataArray[row]
    }
}
