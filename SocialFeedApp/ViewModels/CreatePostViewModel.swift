//
//  CreatePostViewModel 2.swift
//  SocialFeedApp
//
//  Created by Prabhakaran on 27/10/25.
//


import SwiftUI
import Combine
internal import CoreData


class CreatePostViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var description: String = ""
    @Published var manualLocation: String = ""
    @Published var useManualLocation: Bool = false
    @Published var showImagePicker: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func createPost(locationString: String, completion: @escaping () -> Void) {
        guard let image = selectedImage else {
            alertMessage = "Please select an image"
            showAlert = true
            return
        }
        
        guard !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            alertMessage = "Please add a description"
            showAlert = true
            return
        }
        
        let finalLocation: String
        if useManualLocation && !manualLocation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            finalLocation = manualLocation.trimmingCharacters(in: .whitespacesAndNewlines)
        } else if !locationString.isEmpty {
            finalLocation = locationString
        } else if !manualLocation.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            finalLocation = manualLocation.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            alertMessage = "Please provide a location (automatic or manual)"
            showAlert = true
            return
        }
        
        let postEntity = PostEntity(context: context)
        postEntity.id = UUID()
        postEntity.imageData = image.jpegData(compressionQuality: 0.8)
        postEntity.descriptionText = description.trimmingCharacters(in: .whitespacesAndNewlines)
        postEntity.location = finalLocation
        postEntity.timestamp = Date()
        postEntity.likesCount = 0
        postEntity.isLiked = false
        
        PersistenceController.shared.save()
        
        selectedImage = nil
        description = ""
        manualLocation = ""
        useManualLocation = false
        
        completion()
    }
}
