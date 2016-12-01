//
//  File.swift
//  memetest
//
//  Created by MARK on 11/1/16.
//  Copyright © 2016 MARK. All rights reserved.
//

import Foundation
import UIKit
class TextFieldDelegate: NSObject, UITextFieldDelegate {
  
    override init() {
        super.init()
        
    }
     //set up text field behaviors, together with storyboard
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = NSTextAlignment.center
        textField.autocapitalizationType = UITextAutocapitalizationType.allCharacters
         let newText = textField.text! as NSString
        _ = newText.replacingCharacters(in: range, with: string) as NSString
         return newText.length<=15
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 }
