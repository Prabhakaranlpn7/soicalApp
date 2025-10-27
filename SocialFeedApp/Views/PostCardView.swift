//
//  PostCardView.swift
//  SocialFeedApp
//
//  Created by Prabhakaran on 27/10/25.
//


import SwiftUI
internal import CoreData


struct PostCardView: View {
    let post: Post
    let viewModel: FeedViewModel
    
    @State private var showComments = false
    @State private var commentText = ""
    @State private var showShareAlert = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            if let image = post.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .clipped()
                
            }
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 16) {
                    Button(action: {
                        viewModel.toggleLike(for: post)
                    }) {
                        Image(systemName: post.isLiked ? "heart.fill" : "heart")
                            .font(.system(size: 24))
                            .foregroundColor(post.isLiked ? .red : .primary)
                    }
                    
                    Button(action: {
                        showComments.toggle()
                    }) {
                        Image(systemName: "bubble.right")
                            .font(.system(size: 24))
                            .foregroundColor(.primary)
                    }
                    
                    Button(action: {
                        showShareAlert = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 24))
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                
                if post.likesCount > 0 {
                    Text("\(post.likesCount) \(post.likesCount == 1 ? "like" : "likes")")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 16)
                }
                
                Text(post.description)
                    .font(.body)
                    .padding(.horizontal, 16)
                
                HStack(spacing: 4) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(post.location)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 16)
                
                if !post.comments.isEmpty {
                    Button(action: {
                        showComments.toggle()
                    }) {
                        Text("View all \(post.comments.count) \(post.comments.count == 1 ? "comment" : "comments")")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 16)
                }
                
                Text(timeAgo(from: post.timestamp))
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
            }
        }
        .background(Color(uiColor: .systemBackground))
        .cornerRadius(0)
        .sheet(isPresented: $showComments) {
            CommentsView(postId: post.id, viewModel: viewModel)
        }
        .alert("Share Post", isPresented: $showShareAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Post sharing  successfully!")
        }
    }
    
    private func timeAgo(from date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
