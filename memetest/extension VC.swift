//
//  extension VC.swift
//  memetest
//
//  Created by MARK on 10/30/16.
//  Copyright © 2016 MARK. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController {
    
    func showTextField(textField: UITextField) {
        textField.backgroundColor = UIColor.white
        textField.font?.withSize(20)
        textField.textAlignment = NSTextAlignment.center
        textField.sizeToFit()
        textField.defaultTextAttributes = memeDefaultTextAttributes
    }
    func generateMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        toolBarVisible(visible: false)
        return memedImage
    }
    func imagePicker(imagePickerSourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = imagePickerSourceType
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = image
            dismiss(animated: true, completion: nil)
        }
    }
    //set up share/save
    func iimage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func toolBarVisible(visible: Bool){
        if !visible {
            topNaviBar.isHidden = true
            bottomToolBar.isHidden = true
        } else {
            topNaviBar.isHidden = false
            bottomToolBar.isHidden = false  
        }
    }
    //setup keyboard on screen
 
    func keyboardWillShow(notification: NSNotification) {
        if bottomText.isFirstResponder {
        _ = getKeyboardHeight(notification: notification)
        view.frame.origin.y -= getKeyboardHeight(notification: notification)
        }
    }
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue //of CGRect
        return keyboardSize.cgRectValue.height
    }
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow,object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow,object: nil)
    }
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func startOver() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
}
