//
//  FeedView.swift
//  SocialFeedApp
//
//  Created by Prabhakaran on 27/10/25.
//

import SwiftUI
internal import CoreData

struct FeedView: View {
//    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: FeedViewModel
    @State private var showDeleteAlert = false
    
    
    init() {
        let context = PersistenceController.shared.container.viewContext
        
        let initialViewModel = FeedViewModel(context: context)
        
        _viewModel = StateObject(wrappedValue: initialViewModel)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    if viewModel.posts.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            
                            Text("No Posts Yet")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("Create your first post to get started")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 100)
                    } else {
                        ForEach(viewModel.posts) { post in
                            PostCardView(post: post, viewModel: viewModel)
                                .padding(.vertical, 1)
                        }
                    }
                }
            }
            .navigationTitle("Feeds")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                Button(role: .destructive) {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                    .foregroundColor(.red)
                    }
                }
            }
            .refreshable {
                viewModel.fetchPosts()
            }
            .alert("Delete All Posts", isPresented: $showDeleteAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Delete All", role: .destructive) {
                    viewModel.deleteAllPosts()
                    }
                } message: {
                    Text("Are you sure you want to delete all posts? This action cannot be undone.")
                }
            .onAppear{
                viewModel.fetchPosts()
            }
        }
    }
}
