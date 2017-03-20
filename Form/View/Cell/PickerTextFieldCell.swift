//
//  PickerTextFieldCell.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import UIKit


protocol PickerTextFieldCellDelegate: class {
    /**
     自分のセルをリロードさせる
     */
    func cellReload()
}


/**
 PickerTextFieldCell
 */
class PickerTextFieldCell: UITableViewCell, UITextFieldDelegate, PickerTextFieldDelegate {
    
    weak var delegate: PickerTextFieldCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: PickerTextField!
    @IBOutlet weak var textFieldBaseView: UIView!
    @IBOutlet weak var requiredLabel: UILabel!
    
    @IBOutlet weak var errorBaseView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    /// セルのデータ
    var cellData: PickerTextFieldCellData! {
        didSet {
            
            // TextFieldに文字列を設定する
            if let index = cellData.dataArray.index(value: cellData.value) {
                textField.text = cellData.dataArray.pickerStringArray[index]
            } else {
                textField.text = ""
            }
        
            textField.placeholder = cellData.placeholder
            textField.pickerDataArray = cellData.dataArray.pickerStringArray
            textField.defaultText = textField.text
            
            errorMessage = cellData.validationResult.errorMessage
            
            titleLabel.text = cellData.title
            requiredLabel.isHidden = !cellData.isRequired
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
        textField.pickerTextFieldDelegate = self
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        // 選択している項目を反映
        self.textField.defaultText = textField.text
        return true
    }
    
    /**
     TextField入力終了時に呼ばれる
     */
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        cellData.value = cellData.dataArray.picker(text: textField.text!)
        // エラーチェック
        cellData.errorCheck()
        // Tableをリロード
        delegate?.cellReload()
    }
}
