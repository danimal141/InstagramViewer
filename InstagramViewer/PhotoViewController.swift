//
//  PhotoViewController.swift
//  InstagramViewer
//
//  Created by Hideaki Ishii on 3/15/15.
//  Copyright (c) 2015 danimal141. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var standardImage: UIImageView!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let data = NSData(contentsOfURL: self.photo!.standardURL!)
        self.standardImage.image = UIImage(data: data!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
