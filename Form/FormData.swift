//
//  FormData.swift
//  Form
//
//  Created by Kentarou on 2017/03/18.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import Foundation


class FormData {
    
    var text: String
    var date: String
    var pickerCode: String
    var twoPickerCode: String
    
    init(text: String = "",
         date: String = "",
         pickerCode: String = "",
         twoPickerCode: String = "") {
        
        self.text = text
        self.date = date
        self.pickerCode = pickerCode
        self.twoPickerCode = twoPickerCode
    }
    
    func printFormData() {
        dump(self)
    }
    
    func resetFormData() {
        text = ""
        date = ""
        pickerCode = ""
        twoPickerCode = ""
    }
    
    func updateFormData(dict: Dictionary<String, String>) {
        
        text = dictionaryString(dict: dict, key: "name")
    }
    
    func dictionaryString(dict: Dictionary<String, String>, key: String) -> String {
        if let value = dict[key] {
            return value
        }
        return ""
    }
}
