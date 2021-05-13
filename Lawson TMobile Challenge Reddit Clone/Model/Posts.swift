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
    }
    
    var children: [Child]
    
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
    }
    
    var title: String
    
}
