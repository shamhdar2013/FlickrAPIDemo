//
//  DataFetcher.swift
//  FlickerPhotoOrganizer
//
//  Created by RADHIKA SHARMA on 8/22/18.
//  Copyright © 2018 RADHIKA SHARMA. All rights reserved.
//

import UIKit

class DataFetcher: NSObject {
    
    static let apiKey = "c218ba5ef8436840354450442502d713"
    static let secret = "c583fa54fa77245d"
    static let baseUrl = "https://api.flickr.com/services/rest/?&format=json&nojsoncallback=1"
    static let listMethod = "method=flickr.photos.getRecent"
    static let searchMethod = "method=flickr.photos.search"
    
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
        case BadData = "ERROR: bad data"
    }
    
    class func getFlickerPhotos(completion:@escaping([PhotoViewModel
        ]?, Error?)->Void) {
        let session = URLSession.shared
        let urlStr = String(format:"%@&%@&api_key=%@", baseUrl, listMethod, apiKey)
        
        if let listUrl = URL(string:urlStr ) {
            let dataTask = session.dataTask(with: listUrl) { (data, response, error) in
                
                if let data = data {
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? Dictionary<String, Any> {
                            let photoArray = DataFetcher.parsePhotosData(json: json)
                            completion(photoArray, nil)
                        }
                    } catch {
                        //print(error)
                        completion(nil, JSONError.BadData)
                    }
                } else {
                    completion(nil, JSONError.NoData)
                }
            }
            
            dataTask.resume()
        }
    }
    
    
    class func getImage(photo:PhotoViewModel, completion:@escaping(UIImage?, Error?)->Void) {
        if let photoUrl = photo.photoUrl() {
            
            let dataTask = URLSession.shared.dataTask(with: photoUrl) { (data, response, error) in
                
                if let data = data, let img = UIImage(data: data) {
                    photo.photoImage = img
                   completion(img, nil)
                }
            }
            dataTask.resume()
        }
    }
    
    class func searchPhotos(tags: String, completion:@escaping([PhotoViewModel]?, Error?)->Void) {
        let session = URLSession.shared
        
        var  urlStr = String(format:"%@&%@&api_key=%@&tags=%@", baseUrl, searchMethod, apiKey, tags)
        if let escapedTags = tags.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)  {
            urlStr = String(format:"%@&%@&api_key=%@&tags=%@", baseUrl, searchMethod, apiKey, escapedTags)
        }
        
        
        if let listUrl = URL(string:urlStr ) {
            let dataTask = session.dataTask(with: listUrl) { (data, response, error) in
                
                if let data = data {
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? Dictionary<String, Any> {
                            //print(json)
                            let photoArray = DataFetcher.parsePhotosData(json: json)
                            completion(photoArray, nil)
                        }
                    } catch {
                        //print(error)
                        completion(nil, JSONError.BadData)
                    }
                } else {
                    completion(nil, JSONError.NoData)
                }
            }
            dataTask.resume()
        }
    }
    
    class func parsePhotosData(json:Dictionary<String, Any>) -> [PhotoViewModel] {
        var photoArray = [PhotoViewModel]()
        if let photos = json["photos"] as? Dictionary<String,Any>, let items = photos["photo"] as? Array<Dictionary<String, Any>> {
            
            if !items.isEmpty && items.count > 0 {
                
                for item in items {
                    if let iden = item["id"] as? String {
                        let pvm = PhotoViewModel(id: iden)
                        
                        if let ttl = item["title"] as? String, let owner = item["owner"] as? String {
                            pvm.title = ttl
                            pvm.owner = owner
                        }
                        
                        if let farm = item["farm"] as? String {
                            pvm.farm = farm
                        }
                        
                        if let secret = item["secret"] as? String {
                            pvm.secret = secret
                        }
                        
                        if let server = item["server"] as? String {
                            pvm.server = server
                        }
                        
                        photoArray.append(pvm)
                    }
                }
            }
        }
        
        return photoArray
    }

}
