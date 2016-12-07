//
//  MemedetailVC.swift
//  memetest
//
//  Created by MARK on 11/20/16.
//  Copyright © 2016 MARK. All rights reserved.
//

import UIKit
class MemeDetailViewController: UIViewController, UIApplicationDelegate {
 //   var meme: [Meme]!
    var meme: Meme!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadInputViews()
        self.label.text = "\(self.meme.topText)"
        self.imageView!.image = UIImage(named: "\(meme.memedImage)")
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
   
}
