//
//  FeedViewModel.swift
//  SocialFeedApp
//
//  Created by Prabhakaran on 27/10/25.
//

import SwiftUI
import Combine
internal import CoreData


class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchPosts()
    }
    
    func fetchPosts() {
        let request = NSFetchRequest<PostEntity>(entityName: "PostEntity")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \PostEntity.timestamp, ascending: false)]
        
        do {
            let entities = try context.fetch(request)
            print("entities = = = ",entities)
            posts = entities.map { entity in
                let rawCommentsArray: [CommentEntity] = {
                    if let set = entity.comments as? Set<CommentEntity> {
                        return Array(set)
                    } else if let nsset = entity.comments as? NSSet, let set = nsset as? Set<CommentEntity> {
                        return Array(set)
                    } else if let nsset = entity.comments as? NSSet, let array = nsset.allObjects as? [CommentEntity] {
                        return array
                    } else {
                        return []
                    }
                }()
                let comments = rawCommentsArray
                    .sorted { ($0.timestamp ?? Date.distantPast) < ($1.timestamp ?? Date.distantPast) }
                    .map { Comment(id: $0.id ?? UUID(), text: $0.text ?? "", timestamp: $0.timestamp ?? Date()) }
                
                return Post(
                    id: entity.id ?? UUID(),
                    imageData: entity.imageData,
                    description: entity.descriptionText ?? "",
                    location: entity.location ?? "",
                    timestamp: entity.timestamp ?? Date(),
                    likesCount: Int(entity.likesCount),
                    isLiked: entity.isLiked,
                    comments: comments
                )
            }
        } catch {
            print("Failed to fetch posts: \(error)")
        }
    }
    
    func toggleLike(for post: Post) {
        let request = NSFetchRequest<PostEntity>(entityName: "PostEntity")
        request.predicate = NSPredicate(format: "id == %@", post.id as CVarArg)
        
        do {
            if let entity = try context.fetch(request).first {
                entity.isLiked.toggle()
                entity.likesCount += entity.isLiked ? 1 : -1
                PersistenceController.shared.save()
                fetchPosts()
            }
        } catch {
            print("Failed to toggle like: \(error)")
        }
    }
    
 
    
    func addComment(to post: Post, text: String) {
        let request = NSFetchRequest<PostEntity>(entityName: "PostEntity")
        request.predicate = NSPredicate(format: "id == %@", post.id as CVarArg)

        do {
            if let postEntity = try context.fetch(request).first {
                let comment = CommentEntity(context: context)
                comment.id = UUID()
                comment.text = text
                comment.timestamp = Date()
                comment.post = postEntity

                PersistenceController.shared.save()

                if let index = posts.firstIndex(where: { $0.id == post.id }) {
                    var updatedPost = posts[index]
                    let newComment = Comment(id: comment.id!,
                                             text: comment.text!,
                                             timestamp: comment.timestamp!)
                    updatedPost.comments.append(newComment)
                    posts[index] = updatedPost
                }
            } else {
                print("id not found = = ",post.id)
            }
        } catch {
            print("Failed = = \(error)")
        }
    }


    
    func deletePost(_ post: Post) {
        let request = NSFetchRequest<PostEntity>(entityName: "PostEntity")
        request.predicate = NSPredicate(format: "id == %@", post.id as CVarArg)
        
        do {
            if let entity = try context.fetch(request).first {
                context.delete(entity)
                PersistenceController.shared.save()
                fetchPosts()
            }
        } catch {
            print("Failed to delete post: \(error)")
        }
    }
    
    func deleteAllPosts() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PostEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
            context.reset()
            DispatchQueue.main.async {
                self.posts = []
            }
            } catch {
                print("Failed to delete all posts: \(error)")

            }
        }
}

