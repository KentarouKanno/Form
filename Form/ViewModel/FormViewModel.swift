//
//  FormViewModel.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation
import UIKit

protocol FormCellType {
    
    func createCell(index: IndexPath) -> UITableViewCell
}

class FormViewModel {
    
    var dataArray: [[CellViewModelType]] = []
    
    init<vc: UIViewController>(viewController: vc) where vc: FormViewControllerType  {
        
        /// 氏名セル
        let textxFieldCellViewModel = TextFieldCellVewModel.createCellViewModel(viewController: viewController, value: "")
        
        // 生年月日
        let datePickerTextFieldCellViewModel = DatePickerTextFieldCellVewModel.createCellViewModel(viewController: viewController, value: "")
        
        // ブランクセル
        let blankCellViewModel = BlankCellVewModel.createCellViewModel(viewController: viewController)
        
        // 選択肢
        let data0 = PickerData(code: "0", title: "選択してください")
        let data1 = PickerData(code: "1", title: "選択肢1")
        let data2 = PickerData(code: "2", title: "選択肢2")
        let data3 = PickerData(code: "3", title: "選択肢3")
        let pickerDataArray = PickerDataArray(array: [data0, data1, data2, data3])
        
        let pickerTextFieldCellViewModel = PickerTextFieldCellVewModel.createCellViewModel(viewController: viewController,
                                                                                           value: "1",
                                                                                           dataArray: pickerDataArray)
        
        // 学歴
        let twoColumnPickerTextFieldCellViewModel = TwoColumnPickerTextFieldCellVewModel.createCellViewModel(viewController: viewController, value: "")
        
        
        // 質問
        let textViewCellViewModel = TextViewCellVewModel.createCellViewModel(viewController: viewController, value: "")
        
        
        
        dataArray.append([textxFieldCellViewModel, datePickerTextFieldCellViewModel, pickerTextFieldCellViewModel, blankCellViewModel, twoColumnPickerTextFieldCellViewModel, textViewCellViewModel])
        dataArray.append([blankCellViewModel])
    }
    
    func errorLog() {
        
        for section in dataArray {
            for row in section {
                
                row.cellData?.errorCheck()
                
                if let errorMessage = row.cellData?.validationResult.createFormatString() {
                    print(errorMessage)
                }
            }
        }
    }
}
