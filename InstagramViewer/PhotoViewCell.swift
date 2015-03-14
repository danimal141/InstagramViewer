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
    }
    
    class func rowHeight(photo: Photo) -> CGFloat {
        return 75.0 //thumbnail width: 150, height: 150
    }
    
    func configure(photo: Photo) -> PhotoViewCell {
        self.textLabel?.text = photo.caption?.text
        
        let data = NSData(contentsOfURL: photo.thumbnailURL!)
        self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.imageView?.image = UIImage(data: data!)
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return self
    }
    
}
