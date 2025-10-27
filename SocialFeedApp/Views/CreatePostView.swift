//
//  CreatePostView.swift
//  SocialFeedApp
//
//  Created by Prabhakaran on 27/10/25.
//


import SwiftUI
internal import CoreLocation
import PhotosUI
internal import CoreData



struct CreatePostView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel: CreatePostViewModel
    @StateObject private var locationManager = LocationManager()
    
    @State private var showSuccessAlert = false
    @State private var selectedItem: PhotosPickerItem?
    @Binding var selectedTab: Int
    
    init(selectedTab: Binding<Int>) {
        self._selectedTab = selectedTab
        let context = PersistenceController.shared.container.viewContext
        _viewModel = StateObject(wrappedValue: CreatePostViewModel(context: context))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Photo", systemImage: "camera.fill")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            Group {
                                if let image = viewModel.selectedImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 250)
                                        .clipped()
                                        .cornerRadius(12)
                                } else {
                                    VStack(spacing: 12) {
                                        Image(systemName: "photo.on.rectangle.angled")
                                            .font(.system(size: 50))
                                            .foregroundColor(.gray)
                                        
                                        Text("Tap to select photo")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 250)
                                    .background(Color(uiColor: .systemGray6))
                                    .cornerRadius(12)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Description", systemImage: "text.alignleft")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        TextEditor(text: $viewModel.description)
                            .frame(height: 120)
                            .padding(8)
                            .background(Color(uiColor: .systemGray6))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(uiColor: .systemGray4), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal, 16)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Location", systemImage: "mappin.and.ellipse")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Current Location")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                if locationManager.isLoading {
                                    HStack {
                                        ProgressView()
                                            .scaleEffect(0.8)
                                        Text("Fetching location...")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                } else if !locationManager.locationString.isEmpty {
                                    Text(locationManager.locationString)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                } else {
                                    Text(locationStatusText())
                                        .font(.caption)
                                        .foregroundColor(.orange)
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                locationManager.requestLocation()
                            }) {
                                Image(systemName: "location.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.blue)
                            }
                            .disabled(locationManager.isLoading)
                        }
                        .padding(12)
                        .background(Color(uiColor: .systemGray6))
                        .cornerRadius(8)
                        
                        Toggle("Enter location manually", isOn: $viewModel.useManualLocation)
                            .font(.subheadline)
                        
                        if viewModel.useManualLocation {
                            TextField("Enter location", text: $viewModel.manualLocation)
                                .textFieldStyle(.plain)
                                .padding(12)
                                .background(Color(uiColor: .systemGray6))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(uiColor: .systemGray4), lineWidth: 1)
                                )
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    // Post Button
                    Button(action: createPost) {
                        Text("Create Post")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
                .padding(.top, 16)
            }
            .navigationTitle("Create Post")
            .navigationBarTitleDisplayMode(.large)
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.alertMessage)
            }
            .alert("Success", isPresented: $showSuccessAlert) {
                Button("OK", role: .cancel) {
                    selectedTab = 0
                }
            } message: {
                Text("Post created successfully!")
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        viewModel.selectedImage = image
                    }
                }
            }
        }
    }
    
    private func locationStatusText() -> String {
        switch locationManager.authorizationStatus {
        case .denied, .restricted:
            return "Location access denied. Use manual input."
        case .notDetermined:
            return "Tap to enable location"
        default:
            return "Tap to fetch location"
        }
    }
    
    private func createPost() {
        viewModel.createPost(locationString: locationManager.locationString) {
            showSuccessAlert = true
        }
    }
}
