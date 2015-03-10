//
//  PhotoManager.swift
//  InstagramViewer
//
//  Created by Hideaki Ishii on 3/10/15.
//  Copyright (c) 2015 danimal141. All rights reserved.
//

import UIKit
import SwiftyJSON

class PhotoManager: NSObject {
    var photoList: [Photo] = []
    
    class func sharedManager() -> PhotoManager {
        struct Singleton {
            static let instance = PhotoManager()
        }
        return Singleton.instance
    }
    
    func parseData(json: JSON) -> Photo {
        let caption = Caption(
            username: json["caption"]["from"]["username"].string,
            text: json["caption"]["text"].string
        )
        let photo = Photo(
            caption: caption,
            thumbnailURL: json["images"]["thumbnail"]["url"].URL,
            standardURL: json["images"]["standard_resolution"]["url"].URL
        )
        return photo
    }
    
    func getPopular(success: (([Photo]) -> Void)?, failure: ((NSError?) -> Void)?) {
        InstagramAPIClient.sharedClient().getPopular({ (json) in
            if let array = json["data"].array {
                array.map({ (elem: JSON) in self.photoList.append(self.parseData(elem))})
                println(self.photoList)
                success?(self.photoList)
            }
        }, failure: { (error) in
            println(error)
            failure?(error)
        })
    }
}