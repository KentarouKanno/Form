//
//  CustomTextField.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation
import UIKit

/**
 CustomTextFieldDelegate
 */
@objc
protocol CustomTextFieldDelegate: class {
    /**
     Doneボタン押下
     - parameters textField: CustomTextField
     - parameters text: 入力されている文字列
     */
    @objc optional func donePressed(textField: CustomTextField, text: String)
    
    /**
     Cancelボタン押下
     - parameters textField: CustomTextField
     */
    @objc optional func cancelPressed(textField: CustomTextField)
}

/**
 Toolbar付きCustomTextFieldクラス
 */
class CustomTextField: UITextField {
    
    // Delegate
    weak var customTextFieldDelegate: CustomTextFieldDelegate?
    
    /** 
     初期化
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    /// inputAccessoryView
    override var inputAccessoryView: UIView? {
        get {
            
            /// ToolBar
            let toolBar = UIToolbar()
            toolBar.barStyle = .default
            toolBar.isTranslucent = true
            toolBar.tintColor = .black
            
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
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                              target: nil,
                                              action: nil)
            
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            toolBar.sizeToFit()
            
            return toolBar
        }
        set {}
    }
    
    /**
     Doneボタン押下時処理
    */
    @objc private func donePressed() {
        if let text = text {
            customTextFieldDelegate?.donePressed?(textField: self, text: text)
        }
        resignFirstResponder()
    }
    
    /**
     Cancelボタン押下時処理
    */
    @objc private func cancelPressed() {
        
        customTextFieldDelegate?.cancelPressed?(textField: self)
        resignFirstResponder()
    }
}
