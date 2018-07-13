//
//  FlickrDataModel.swift
//  HMFlickr
//
//  Created by Hayden Malcomson on 2018-07-12.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import Foundation
import UIKit

class FlickrImageObject: NSObject {
    let uniqueID: String
    let controllerClass: UIViewController.Type
    let controllerIdentifier: String?
    let flickrImage: FlickrImage
    
    init(
        controllerClass: UIViewController.Type,
        controllerIdentifier: String? = nil,
        flickrImage: FlickrImage
        ) {
        self.uniqueID = flickrImage.description
        self.controllerClass = controllerClass
        self.controllerIdentifier = controllerIdentifier
        self.flickrImage = flickrImage
    }
    
}

struct FlickrPublicFeed: Codable {
    let title : String?
    let link: String?
    let description : String?
    let modified: Date?
    let generator: String?
    let items: [FlickrImage]?
}

struct FlickrImage: Codable {
    
    let title : String
    let link: String
    let media: FlickrImageMedia
    let dateTaken: Date
    let description: String
    let published: Date
    let author: String
    let authorId: String
    let tags: String
    
    private enum CodingKeys: String, CodingKey {
        case dateTaken = "date_taken"
        case title
        case link
        case media
        case description
        case published
        case authorId = "author_id"
        case author
        case tags
    }
}

extension FlickrImage {
    
    var tagArray: [String]? {
        if self.tags.isEmpty { return nil }
        let tagArray = tags.components(separatedBy: " ")
        if tagArray.isEmpty { return nil }
        return tagArray
    }
    
    func constructFlickrItemSectionDataSource() -> [FlickrItemSectionItem] {
        var dataSource: [FlickrItemSectionItem] = []
        dataSource.append(.header(flickrItem: self))
        dataSource.append(FlickrItemSectionItem.image(image: URL(string: self.media.imageUrlString)))
        if let tags = self.tagArray {
            dataSource.append(FlickrItemSectionItem.tags(tagsArray: tags))
        }
        return dataSource
    }
    
}

struct FlickrImageMedia: Codable {
    private enum CodingKeys: String, CodingKey {
        case imageUrlString = "m"
    }
    let imageUrlString: String
}

