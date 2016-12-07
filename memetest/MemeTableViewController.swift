//
//  MemeTableViewController.swift
//  memetest
//
//  Created by MARK on 11/19/16.
//  Copyright © 2016 MARK. All rights reserved.
//

import UIKit


class MemeTableViewController:UITableViewController, UIApplicationDelegate {
    var memeAll: [Meme]!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        //to get shared data
         let applicationDelegate = (UIApplication.shared.delegate as! AppDelegate)
        memeAll =  applicationDelegate.memeAll
         self.tableView?.reloadData()
      //  tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(memeAll.count)
        return memeAll.count
    }
    
    //to get cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"memesCell")!
        let allmeme =  memeAll[(indexPath as NSIndexPath).row]
   //     cell.textLabel?.text = allmeme.topText
        
        cell.textLabel?.text = "\(allmeme.topText)"
        cell.imageView?.image = allmeme.memedImage
        return cell
    }
    //for detail view
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        detailController.meme = memeAll[indexPath.row]
        print(indexPath)
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
}
