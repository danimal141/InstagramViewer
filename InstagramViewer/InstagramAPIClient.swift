//
//  InstagramAPIClient.swift
//  InstagramViewer
//
//  Created by Hideaki Ishii on 3/10/15.
//  Copyright (c) 2015 danimal141. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class InstagramAPIClient: NSObject {
    let url = "https://api.instagram.com/v1/media/popular"
    let param = ["client_id": "11ac3c059a804539b3855464dd7660b4"]
    
    class func sharedClient() -> InstagramAPIClient {
        struct Singleton {
            static let instance = InstagramAPIClient()
        }
        return Singleton.instance
    }
    
    func getPopular(completionHandler: ((JSON?, NSError?) -> Void)?) {
        Alamofire.request(.GET, url, parameters: param).responseJSON { (req, res, data, error) in
            if error == nil {
                let json = JSON(data!)
                completionHandler?(json, error)
            } else {
                completionHandler?(nil, error)
            }
        }
    }
}