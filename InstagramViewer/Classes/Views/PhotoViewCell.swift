//
//  PhotoViewCell.swift
//  InstagramViewer
//
//  Created by Hideaki Ishii on 3/14/15.
//  Copyright (c) 2015 danimal141. All rights reserved.
//

import UIKit

class PhotoViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textLabel?.numberOfLines = 0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView?.image = nil
        self.textLabel?.text = nil
    }
    
    class func rowHeight(photo: Photo) -> CGFloat {
        return 75.0 //thumbnail width: 150, height: 150
    }
    
    func configure(photo: Photo) -> PhotoViewCell {
        self.textLabel?.text = photo.caption?.text
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        let q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let q_main = dispatch_get_main_queue()
        dispatch_async(q_global, {
            let data = NSData(contentsOfURL: photo.thumbnailURL!)
            dispatch_async(q_main, {
                self.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
                self.imageView!.image = UIImage(data: data!)
                self.setNeedsLayout()
            })
        })
        return self
    }
}
