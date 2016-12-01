//
//  ViewController.swift
//  memetest
//
//  Created by MARK on 10/26/16.
//  Copyright © 2016 MARK. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var memeAll: [Meme]! //for data sharing
    var meme: Meme!
    //text attributes for default
    let memeDefaultTextAttributes =
         [NSStrokeColorAttributeName as String : UIColor.black,
         NSForegroundColorAttributeName as String : UIColor.white,
         NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
         NSStrokeWidthAttributeName as String : -3.0,
              ] as [String : Any]
    
    let topTextDelegate = TextFieldDelegate()
    let bottomTextDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTextField(textField: topText)
        topText.text = "Tap to add a title"
        showTextField(textField: bottomText)
        bottomText.text = "Tap to add descriptions"
        camera.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        topText.delegate = topTextDelegate
        bottomText.delegate = bottomTextDelegate
//        view.topNaviBar.size.width: CGFloat = 1.0
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "start over", style: .plain, target: self, action: #selector(startOver))
    }
    override func viewWillAppear(_ _animated: Bool) {
        super.viewWillAppear(_animated)
        subscribeToKeyboardNotifications()
    }
    
    //set up all connections/actions/outlets
    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topToolBar: UIToolbar!
    
    @IBOutlet weak var topNaviBar: UINavigationBar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var camera: UIBarButtonItem!
    
     //to get images
    @IBAction func takeAImageFromAlbum(_ sender: AnyObject) {
        imagePicker(imagePickerSourceType: UIImagePickerControllerSourceType.photoLibrary)
    }
    @IBAction func imageFromCamera(_ sender: AnyObject) {
        imagePicker(imagePickerSourceType: UIImagePickerControllerSourceType.camera)
    }
    
    //to edit and share images
    @IBAction func cancelButton(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if camera.isEnabled {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
           } else {
            UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)
                }
        present(imagePicker, animated: true, completion: nil)
    }
 
    @IBAction func share(_ sender: AnyObject) {
        let memeToShare = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memeToShare], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save(memeToShare)
                }
            }
        present(activityViewController, animated: true, completion: nil)
        toolBarVisible(visible: true)
     }
    
    @IBAction func save(_ sender: AnyObject) {
        let meme = Meme(topText: topText, bottomText: bottomText, image:
            imagePickerView.image!, memedImage: generateMemedImage())
        UIImageWriteToSavedPhotosAlbum(generateMemedImage(), meme, nil, nil)
        toolBarVisible(visible: true)
        //to save data for table/collection views
        (UIApplication.shared.delegate as! AppDelegate).memeAll.append(meme)
        print((UIApplication.shared.delegate as! AppDelegate).memeAll.count)

    }
}

