//
//  MemeCollectionViewController.swift
//  memetest
//
//  Created by MARK on 11/20/16.
//  Copyright © 2016 MARK. All rights reserved.
//

import Foundation
import UIKit
class MemeCollectionViewController: UICollectionViewController, UIApplicationDelegate {
    
    var memes:[Meme]!
 //   var memes: Meme?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        //to get shared data
        let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        memes =  applicationDelegate.memeAll
        self.collectionView?.reloadData()
        

    }
    override func viewDidAppear(_ animated: Bool) {
        viewDidAppear(true)
        //to get shared data
   //     let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
   //     memes =  applicationDelegate.memeAll
   //     self.collectionView?.reloadData()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int) -> Int {
        return memes.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath as IndexPath) as! MemeCollectionViewCell
        let allMeme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.nameLabel.text = "\(allMeme.bottomText)"
        cell.memeImageView?.image = allMeme.memedImage
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
  
       //
 //       detailVC.meme = [self.memes[(indexPath).row]]
        detailVC.meme = self.memes[(indexPath).row]
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
}
