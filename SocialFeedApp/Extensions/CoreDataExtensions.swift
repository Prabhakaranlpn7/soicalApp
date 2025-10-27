//
//  CoreDataExtensions.swift
//  SocialFeedApp
//
//  Created by Prabhakaran on 27/10/25.
//

import SwiftUI


// NOTE:
// Core Data model code (NSManaged properties and fetchRequest()) is typically generated
// by Xcode in your NSManagedObject subclasses. Duplicating them here causes
// "Invalid redeclaration" compiler errors. This file provides only convenience helpers.

extension PostEntity {
    // Typed convenience accessor for comments as a Swift Set
    public var commentsSet: Set<CommentEntity> {
        (comments as? Set<CommentEntity>) ?? []
    }

    // Sorted comments by timestamp descending (newest first)
    public var sortedComments: [CommentEntity] {
        commentsSet.sorted { (lhs, rhs) in
            let l = lhs.timestamp ?? .distantPast
            let r = rhs.timestamp ?? .distantPast
            return l > r
        }
    }

    // Convenience safe unwraps for optional fields
    public var wrappedId: UUID { id ?? UUID() }
    public var wrappedDescription: String { descriptionText ?? "" }
    public var wrappedLocation: String { location ?? "" }
    public var wrappedTimestamp: Date { timestamp ?? .distantPast }

    // Helper to set image from UIImage
    public func setImage(_ image: UIImage?) {
        if let image, let data = image.jpegData(compressionQuality: 0.9) {
            self.imageData = data
        } else {
            self.imageData = nil
        }
    }

    // Helper to read image as UIImage
    public var uiImage: UIImage? {
        guard let imageData else { return nil }
        return UIImage(data: imageData)
    }
}

extension CommentEntity {
    // Convenience safe unwraps
    public var wrappedId: UUID { id ?? UUID() }
    public var wrappedText: String { text ?? "" }
    public var wrappedTimestamp: Date { timestamp ?? .distantPast }
}
