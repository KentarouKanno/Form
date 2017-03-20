//
//  CellViewModel.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation
import UIKit

// MARK: - TextFieldCellVewModel

/**
 TextFieldCellのViewModel生成クラス
 */
struct TextFieldCellVewModel  {
    
    static func createCellViewModel<vc: UIViewController>(viewController: vc,
                                    value: String = "",
                                    needErrorCheck: Bool = false) -> TextFieldCellViewModel where vc: FormViewControllerType {
        
        // 氏名
        /* TextFieldCell */
        
        // Error Validation
        let textFieldValidation = TextFieldErrorValidations.validations()
        
        // Cell Data
        let textFieldCellData = TextFieldCellData(title: "氏名",
                                                  placeholder: "例 : 鈴木一郎",
                                                  required: true,
                                                  value: value,
                                                  validations: textFieldValidation)
        
        // CellViewModel
        let textFieldCellViewModel = TextFieldCellViewModel(viewController: viewController,
                                                            cellData: textFieldCellData)
        return textFieldCellViewModel
    }
}

// MARK: - DatePickerTextFieldCellVewModel

/**
 DatePickerTextFieldCellのViewModel生成クラス
 */
struct DatePickerTextFieldCellVewModel  {
    
    static func createCellViewModel<vc: UIViewController>(viewController: vc,
                                    value: String = "",
                                    needErrorCheck: Bool = false) -> DatePickerTextFieldCellViewModel where vc: FormViewControllerType {
        
        // 生年月日
        /* DateTextFieldCell */
        
        // Error Validation
        let dateTextFieldValidation = DatePickerTextFieldErrorValidations.validations()
        
        // Cell Data
        let dateTextFieldCellData = DatePickerTextFieldCellData(title: "生年月日",
                                                                placeholder: "--年--月--日",
                                                                required: false,
                                                                value: value,
                                                                validations: dateTextFieldValidation)
        
        // CellViewModel
        let datePickerTextFieldCellViewModel = DatePickerTextFieldCellViewModel(viewController: viewController,
                                                                                cellData: dateTextFieldCellData)
        return datePickerTextFieldCellViewModel
    }
}

// MARK: - PickerTextFieldCellVewModel

/**
 PickerTextFieldCellのViewModel生成クラス
 */
struct PickerTextFieldCellVewModel  {
    
    static func createCellViewModel<vc: UIViewController>(viewController: vc,
                                    value: String = "",
                                    dataArray: PickerDataArray,
                                    needErrorCheck: Bool = false) -> PickerTextFieldCellViewModel where vc: FormViewControllerType {
        
        // 選択肢
        /* PickerTextFieldCell */
        
        // Error Validation
        let pickerTextFieldValidation = PickerTextFieldErrorValidations.validations()
        
        // Cell Data
        let pickerTextFieldCellData = PickerTextFieldCellData(title: "選択肢",
                                                              placeholder: "選択してください",
                                                              required: true,
                                                              value: value,
                                                              dataArray: dataArray,
                                                              validations: pickerTextFieldValidation)
        
        // CellViewModel
        let pickerTextFieldCellViewModel = PickerTextFieldCellViewModel(viewController: viewController,
                                                                        cellData: pickerTextFieldCellData)
        return pickerTextFieldCellViewModel
    }
}

// MARK: - TwoColumnPickerTextFieldCellVewModel

/**
 TwoColumnPickerTextFieldCellのViewModel生成クラス
 */
struct TwoColumnPickerTextFieldCellVewModel  {
    
    static func createCellViewModel<vc: UIViewController>(viewController: vc,
                                    value: String = "",
                                    needErrorCheck: Bool = false) -> TwoColumnPickerTextFieldCellViewModel where vc: FormViewControllerType {
        
        // 学歴
        /* PickerTextFieldCell */
        
        // Error Validation
        let twoColumnpickerTextFieldValidation = TwoColumnPickerTextFieldErrorValidations.validations()
        
        // Cell Data
        let twoColumnpickerTextFieldCellData = TwoColumnPickerTextFieldCellData(title: "学歴",
                                                                                placeholder: "--年--月",
                                                                                required: true,
                                                                                value: value,
                                                                                validations: twoColumnpickerTextFieldValidation)
        
        // CellViewModel
        let twoPickerTextFieldCellViewModel = TwoColumnPickerTextFieldCellViewModel(viewController: viewController,
                                                                                    cellData: twoColumnpickerTextFieldCellData)
        return twoPickerTextFieldCellViewModel
    }
}

// MARK: - TwoColumnPickerTextFieldCellVewModel

/**
 TextViewCellのViewModel生成クラス
 */
struct TextViewCellVewModel  {
    
    static func createCellViewModel<vc: UIViewController>(viewController: vc,
                                    value: String = "",
                                    needErrorCheck: Bool = false) -> TextViewCellViewModel where vc: FormViewControllerType {
        
        // 質問
        /* TextViewCell */
        
        // Error Validation
        let textViewValidation = TextViewErrorValidations.validations()
        
        // Cell Data
        let textViewCellData = TextViewCellData(title: "質問",
                                                placeholder: "回答を入力してください",
                                                required: true,
                                                value: value,
                                                validations: textViewValidation)
        
        // CellViewModel
        let textViewCellViewModel = TextViewCellViewModel(viewController: viewController,
                                                          cellData: textViewCellData)
        return textViewCellViewModel
    }
}

// MARK: - BlankCellVewModel

/**
 BlankCellのViewModel生成クラス
 */
struct BlankCellVewModel {
    
    static func createCellViewModel<vc: UIViewController>(viewController: vc,
                                    value: String = "",
                                    needErrorCheck: Bool = false) -> BlankCellViewModel where vc: FormViewControllerType {
        
        // ブランクセル
        /* BlankCell */
        
        // Cell Data
        let blankCellData = BlankCellData()
        
        // CellViewModel
        let blankCellViewModel = BlankCellViewModel(viewController: viewController,
                                                    cellData: blankCellData)
        return blankCellViewModel
    }
}
