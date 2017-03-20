//
//  TextViewCell.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import UIKit

protocol TextViewCellDelegate: class {
    func cellReload()
}

class TextViewCell: UITableViewCell, UITextViewDelegate, CustomTextViewDelegate {

    weak var delegate: TextViewCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: CustomTextView!
    @IBOutlet weak var textFieldBaseView: UIView!
    @IBOutlet weak var requiredLabel: UILabel!
    
    @IBOutlet weak var errorBaseView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var textCountLabel: UILabel!
    
    
    /// セルのデータ
    var cellData: TextViewCellData! {
        didSet {
            
            textView.text = cellData.value
            textView.placeHolder = cellData.placeholder
            
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
        
        textView.delegate = self
        textView.customTextViewDelegate = self
    }
    
    
    func textChanged() {
        
        textCountLabel.text = "\(textView.text.utf16.count)/100"
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        return true
    }
    
    /**
     TextField入力終了時に呼ばれる
     */
    func textViewDidEndEditing(_ textView: UITextView) {
        
        cellData.value = textView.text!
        // エラーチェック
        cellData.errorCheck()
        // Tableをリロード
        delegate?.cellReload()
    }
}
