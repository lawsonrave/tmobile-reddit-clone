//
//  Posts.swift
//  Lawson TMobile Challenge Reddit Clone
//
//  Created by ravebizz on 5/2/21.
//

import Foundation

struct Posts: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case allPosts = "data"
    }
    
    var allPosts: Children
    
}

struct Children: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case children = "children"
        case afterLink = "after"
    }
    
    var children: [Child]
    var afterLink: String?
    
}

struct Child: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case post = "data"
    }
    
    var post: Post
    
}

struct Post: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case score = "score"
        case numComments = "num_comments"
        case thumbnail = "thumbnail"
        case thumbnailHeight = "thumbnail_height"
        case thumbnailWidth = "thumbnail_width"
    }
    
    var title: String
    var score: Int
    var numComments: Int
    var thumbnail: String
    var thumbnailHeight: Int?
    var thumbnailWidth: Int?
    
}
