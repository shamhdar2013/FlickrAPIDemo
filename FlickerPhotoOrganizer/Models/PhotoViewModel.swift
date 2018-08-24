//
//  PhotoViewModel.swift
//  FlickerPhotoOrganizer
//
//  Created by RADHIKA SHARMA on 8/22/18.
//  Copyright © 2018 RADHIKA SHARMA. All rights reserved.
//

import UIKit

class PhotoViewModel: NSObject {
    
    var photoImage: UIImage?
    var photoTags: [String]?
    let id: String
    var title: String
    var owner: String
    var secret: String
    var server: String
    var farm: String
    var category: String
    
    enum DefaultValues: String {
        case defaultOwner = "143627770@N02"
        case defaultTitle = "Monsoon Monsoon"
        case defaultSecret = "4658739656"
        case defaultServer = "1849"
        case defaultFarm = "2"
        case defaultCategory = "Public"
        
    }
    
    init(id: String){
        self.id = id
        self.title = DefaultValues.defaultTitle.rawValue
        self.owner = DefaultValues.defaultOwner.rawValue
        self.secret = DefaultValues.defaultSecret.rawValue
        self.farm = DefaultValues.defaultFarm.rawValue
        self.server = DefaultValues.defaultServer.rawValue
        self.category = DefaultValues.defaultCategory.rawValue
        
        if let img = UIImage(named:"Kanga") {
            self.photoImage = img
        }
        
        super.init()
    }
    
    public func photoUrl() -> URL? {
        let urlStr = String(format:"https://farm%@.staticflickr.com/%@/%@_%@.jpg",farm,server,id,secret)
        
        if let url =  URL(string: urlStr) {
            return url
        }
        return nil
    }

}
