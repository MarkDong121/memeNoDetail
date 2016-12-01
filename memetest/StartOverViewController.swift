//
//  StartOverViewController.swift
//  memetest
//
//  Created by MARK on 11/18/16.
//  Copyright © 2016 MARK. All rights reserved.
//

import UIKit
class StopOverViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "start over", style: .plain, target: self, action: #selector(startOver))
    }
    func startOver() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
