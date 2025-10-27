//
//  Post.swift
//  SocialFeedApp
//
//  Created by Prabhakaran on 27/10/25.
//


import SwiftUI
internal import CoreData



struct Post: Identifiable {
    let id: UUID
    var imageData: Data?
    var description: String
    var location: String
    var timestamp: Date
    var likesCount: Int
    var isLiked: Bool
    var comments: [Comment]
    
    var image: UIImage? {
        guard let data = imageData else { return nil }
        return UIImage(data: data)
    }
}
