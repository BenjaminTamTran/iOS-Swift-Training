//
//  PhotosTableViewController.swift
//  demoTableView2
//
//  Created by The Simple Studio on 30/3/16.
//  Copyright © 2016 The Simple Studio. All rights reserved.
//

import Foundation

class Photo
{
    var name: String = ""
    var photographerProfileImageName: String = ""
    var caption: String = ""
    var thumbnailImageName: String = ""
    
    init(name: String, photographerProfileImageName: String, caption: String, thumbnailName: String)
    {
        self.name = name
        self.photographerProfileImageName = photographerProfileImageName
        self.caption = caption
        self.thumbnailImageName = thumbnailName
    }
    
    class func downloadAllPhotos() -> [Photo]
    {
        var photos = [Photo]()
        
        for i in 1...10 {
            let photo = Photo(name: "\(i)", photographerProfileImageName: "p\(i)", caption: "Lorem ipsum dolor sit amet, quo no purto postea, ei melius inciderint mei. Eius ancillae est ex, nonumy nominavi inimicus cu pro. Ut exerci voluptua insolens vix, cum at libris eleifend reprimique. Oblique veritus eleifend pri ea. Solum mandamus constituto ut nec. Veniam quaeque expetendis mea cu, ut vel magna congue, cetero ceteros antiopam has ex. Vocent verterem cum ea, ea vix veniam postea concludaturque.", thumbnailName: "t\(i)")
            photos.append(photo)
        }
        
        return photos
    }
}

/*
 
 Lorem ipsum dolor sit amet, quo no purto postea, ei melius inciderint mei. Eius ancillae est ex, nonumy nominavi inimicus cu pro. Ut exerci voluptua insolens vix, cum at libris eleifend reprimique. Oblique veritus eleifend pri ea. Solum mandamus constituto ut nec. Veniam quaeque expetendis mea cu, ut vel magna congue, cetero ceteros antiopam has ex. Vocent verterem cum ea, ea vix veniam postea concludaturque.
 
 */