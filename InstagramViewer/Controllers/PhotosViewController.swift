//
//  PhotosViewController.swift
//  InstagramViewer
//
//  Created by Hideaki Ishii on 3/14/15.
//  Copyright (c) 2015 danimal141. All rights reserved.
//

import UIKit

class PhotosViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor.clearColor() //hide the line
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "refreshData", forControlEvents: .ValueChanged)
        self.refreshData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PhotoManager.sharedManager().photoList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as PhotoViewCell
        let photo = PhotoManager.sharedManager().photoList[indexPath.row]
        
        return cell.configure(photo)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let photo = PhotoManager.sharedManager().photoList[indexPath.row]
        return PhotoViewCell.rowHeight(photo)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "OpenPhotoSegue" {
            if let selected = self.tableView.indexPathForSelectedRow() {
                let photo = PhotoManager.sharedManager().photoList[selected.row]
                let photoViewController = segue.destinationViewController as PhotoViewController
                photoViewController.photo = photo
            }
        }
    }
    
    func refreshData() {
        self.refreshControl?.beginRefreshing()
        
        PhotoManager.sharedManager().getPopular({ (error) in
            if error != nil { println(error) }
            
            self.tableView.reloadData()
            self.tableView.setNeedsLayout()
            self.refreshControl?.endRefreshing()
        })
    }
}
