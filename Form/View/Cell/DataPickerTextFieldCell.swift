//
//  DataPickerTextFieldCell.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import UIKit


protocol DataPickerTextFieldCellDelegate: class {
    /**
     自分のセルをリロードさせる
     */
    func cellReload()
}


/**
 DataPickerTextFieldCell
 */
class DataPickerTextFieldCell: UITableViewCell, UITextFieldDelegate, DatePickerTextFieldDelegate {
    
    weak var delegate: DataPickerTextFieldCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: DatePickerTextField!
    @IBOutlet weak var textFieldBaseView: UIView!
    @IBOutlet weak var requiredLabel: UILabel!
    
    @IBOutlet weak var errorBaseView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    /// セルのデータ
    var cellData: DatePickerTextFieldCellData! {
        didSet {
            
            self.textField.setDatePicker(dateString: cellData.value)
            textField.placeholder = cellData.placeholder
            
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
        textField.datePickerDelegate = self
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.textField.setDatePicker(dateString: cellData.value)
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
    
    // MARK: - DatePickerTextFieldDelegate
    
    func donePressed(textField: DatePickerTextField, dateString: String) {
        cellData.value = dateString
        
    }
}
