//
//  TwoColumnPickerTextFieldCell.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import UIKit

protocol TwoColumnPickerTextFieldCellDelegate: class {
    /**
     自分のセルをリロードさせる
     */
    func cellReload()
}


/**
 TextFieldCell
 */
class TwoColumnPickerTextFieldCell: UITableViewCell, UITextFieldDelegate, TwoColumnPickerTextFieldDelegate {
    
    weak var delegate: TwoColumnPickerTextFieldCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: TwoColumnPickerTextField!
    @IBOutlet weak var textFieldBaseView: UIView!
    @IBOutlet weak var requiredLabel: UILabel!
    
    @IBOutlet weak var errorBaseView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    /// セルのデータ
    var cellData: TwoColumnPickerTextFieldCellData! {
        didSet {
            
            textField.placeholder = cellData.placeholder
            
            errorMessage = cellData.validationResult.errorMessage
            titleLabel.text = cellData.title
            requiredLabel.isHidden = !cellData.isRequired
            
            textField.defalutValue = "201010"
            textField.defaultText = cellData.value
        }
    }
    
    /// エラーメッセージ
    private var errorMessage: String {
        get { return cellData.validationResult.errorMessage }
        set(errorMessage) {
            
            errorBaseView.isHidden = errorMessage.isEmpty
            errorLabel.text = errorMessage
            textFieldBaseView.backgroundColor = errorMessage.isEmpty ? noErrorBackgroundColor : errorBackgroundColor
        }
    }
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.delegate = self
        textField.twoColumnPickerDelegate = self
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.textField.defaultText = cellData.value
        return true
    }
    
    /**
     TextField入力終了時に呼ばれる
     */
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // エラーチェック
        cellData.errorCheck()
        // Tableをリロード
        delegate?.cellReload()
    }
    
    // MARK: - TwoColumnPickerTextFieldDelegate
    
    func donePressed(textField: TwoColumnPickerTextField, text: String) {
        
        print(text)
        cellData.value = text
    }
}
