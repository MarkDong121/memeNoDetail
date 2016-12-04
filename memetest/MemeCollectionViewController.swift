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
  
    var memeAll: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memeAll
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        //to get shared data
 //       let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
 //       memeAll =  applicationDelegate.memeAll
        self.collectionView?.reloadData()
   //     collectionView?.reloadData()

    }
    override func viewDidAppear(_ animated: Bool) {
        viewDidAppear(true)
        }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section:Int) -> Int {
        print(memeAll.count)
        return self.memeAll.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath as IndexPath) as! MemeCollectionViewCell
 
        let oneMeme = self.memeAll[(indexPath as NSIndexPath).row]
        
   
        
//        cell.nameLabel?.text = "\(oneMeme.topText)"
        cell.memeImageView?.image = oneMeme.memedImage
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
  
       //
 //       detailVC.meme = [self.memes[(indexPath).row]]
        detailVC.meme = self.memeAll[(indexPath).row]
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
}
