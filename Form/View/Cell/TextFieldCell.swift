//
//  TextFieldCell.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import UIKit

let errorBackgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
let noErrorBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)


protocol TextFieldCellDelegate: class {
    /**
     自分のセルをリロードさせる
    */
    func cellReload()
}


/**
 TextFieldCell
 */
class TextFieldCell: UITableViewCell, UITextFieldDelegate, CustomTextFieldDelegate {
    
    weak var delegate: TextFieldCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: CustomTextField!
    @IBOutlet weak var textFieldBaseView: UIView!
    @IBOutlet weak var requiredLabel: UILabel!
    
    @IBOutlet weak var errorBaseView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    /// セルのデータ
    var cellData: TextFieldCellData! {
        didSet {
            
            textField.text = cellData.value
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
        textField.customTextFieldDelegate = self
    }
    
    // MARK: - UITextFieldDelegate
    
    /**
     TextField入力終了時に呼ばれる
    */
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        cellData.value = textField.text!
        // エラーチェック
        cellData.errorCheck()
        // Tableをリロード
        delegate?.cellReload()
    }
}
