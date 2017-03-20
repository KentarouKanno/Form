//
//  CustomTextView.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation
import UIKit

/**
 CustomTextViewDelegate
 */
@objc
protocol CustomTextViewDelegate: class {
    /**
     Doneボタン押下
     - parameters textView: CustomTextView
     - parameters text: 入力されている文字列
     */
    @objc optional func donePressed(textView: CustomTextView, text: String)
    
    /**
     Cancelボタン押下
     - parameters textField: CustomTextView
     */
    @objc optional func cancelPressed(textField: CustomTextView)
    
    
    @objc optional func textChanged()
}

class CustomTextView: UITextView {
    
    /// Delegate
    weak var customTextViewDelegate: CustomTextViewDelegate?
    
    /// placeHolder用のラベル
    lazy var placeHolderLabel:UILabel = UILabel()
    var placeHolderColor:UIColor      = .lightGray
    var placeHolder = ""
    
    /**
     初期化
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    func addNotification() {
        // 文字入力時の通知を登録
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.textChanged(notification:)),
                                               name: NSNotification.Name.UITextViewTextDidChange,
                                               object: nil)
    }
    
    func removeNotification() {
        // 通知を解除
        NotificationCenter.default.removeObserver(self)
    }
    
    
    deinit {
        
    }
    
    override public func draw(_ rect: CGRect) {
        
        if self.placeHolder.utf16.count > 0 {
            self.placeHolderLabel.frame = CGRect(x: 8,
                                                 y: 8,
                                                 width: self.bounds.width - 16,
                                                 height: 0)
            
            self.placeHolderLabel.lineBreakMode   = NSLineBreakMode.byWordWrapping
            self.placeHolderLabel.numberOfLines   = 0
            self.placeHolderLabel.font            = self.font
            self.placeHolderLabel.backgroundColor = .clear
            self.placeHolderLabel.textColor       = self.placeHolderColor
            self.placeHolderLabel.alpha           = 0
            self.placeHolderLabel.tag             = 1
            
            self.placeHolderLabel.text = self.placeHolder as String
            self.placeHolderLabel.sizeToFit()
            self.addSubview(placeHolderLabel)
        }
        
        self.sendSubview(toBack: placeHolderLabel)
        textChanged(notification: nil)
        
        super.draw(rect)
    }
    
    public func textChanged(notification:NSNotification?) {
        
        customTextViewDelegate?.textChanged?()
        
        guard placeHolder.utf16.count != 0 else {
            return
        }
        
        print("self.text = ", self.text.utf16.count)
        
        // placeHolderの表示、非表示の切り替え
        self.viewWithTag(1)?.alpha = self.text.utf16.count == 0 ? 1 : 0
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
            customTextViewDelegate?.donePressed?(textView: self, text: text)
        }
        resignFirstResponder()
    }
    
    /**
     Cancelボタン押下時処理
     */
    @objc private func cancelPressed() {
        
        customTextViewDelegate?.cancelPressed?(textField: self)
        self.resignFirstResponder()
    }
}

