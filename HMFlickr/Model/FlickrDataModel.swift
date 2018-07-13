//
//  FlickrDataModel.swift
//  HMFlickr
//
//  Created by Hayden Malcomson on 2018-07-12.
//  Copyright © 2018 Hayden Malcomson. All rights reserved.
//

import Foundation

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

struct FlickrImageMedia: Codable {
    let m: String
}

