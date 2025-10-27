//
//  CommentsView.swift
//  SocialFeedApp
//
//  Created by Prabhakaran on 27/10/25.
//

import SwiftUI

struct CommentsView: View {
    let postId: UUID
    @ObservedObject var viewModel: FeedViewModel
    
    @Environment(\.dismiss) private var dismiss
    @State private var commentText = ""
    @FocusState private var isTextFieldFocused: Bool
    
    private var currentPost: Post? {
        viewModel.posts.first(where: { $0.id == postId })
    }
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if let post = currentPost {
                    if post.comments.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "bubble.right")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            
                            Text("No comments yet")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            
                            Text("Be the first to comment")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 16) {
                                ForEach(post.comments) { comment in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(comment.text)
                                            .font(.body)
                                        
                                        Text(timeAgo(from: comment.timestamp))
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.horizontal, 16)
                                }
                            }
                            .padding(.vertical, 12)
                        }
                    }
                } else {
                    Text("Post not found")
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Comment Input
                HStack(spacing: 12) {
                    TextField("Add a comment...", text: $commentText)
                        .textFieldStyle(.plain)
                        .padding(10)
                        .background(Color(uiColor: .systemGray6))
                        .cornerRadius(20)
                        .focused($isTextFieldFocused)
                    
                    Button(action: addComment) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 20))
                            .foregroundColor(commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : .blue)
                    }
                    .disabled(commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(uiColor: .systemBackground))
            }
            .navigationTitle("Comments")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                isTextFieldFocused = true
                print("Post in comments == ",postId)
                print("Current post = = ",currentPost)
            }
        }
    }
    
    private func addComment() {
        guard let post = currentPost else { return }
        let trimmedComment = commentText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedComment.isEmpty else { return }
        
        viewModel.addComment(to: post, text: trimmedComment)
        commentText = ""
    }
    
    private func timeAgo(from date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}
