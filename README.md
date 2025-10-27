
## Social Media Feed Application

A fully-featured iOS social media feed application built with SwiftUI and Core Data, following the MVVM architecture pattern. This app allows users to create posts with images, descriptions, and locations, and interact through likes, comments, and sharing.





## 📱 Features

### Create Post
**Image Selection** - Select photos from library using native PhotosPicker
 **Description Input** - Rich text editor for post descriptions
 **Automatic Location** - GPS-based location tagging with CLLocationManager
 **Manual Location** - Fallback text input when location services are unavailable
 **Smart Validation** - Comprehensive error handling and user feedback
 **Permission Handling** - Graceful handling of photo and location permissions

### Feed View
 **Scrollable Feed** - Efficient LazyVStack with smooth scrolling
 **Post Display** - Image, description, location, and timestamp
 **Like System** - Toggle likes with animated heart icon
 **Comment System** - Add and view comments per post
 **Share Simulation** - Simulated sharing functionality
 **Pull to Refresh** - Refresh feed data manually
 **Empty States** - User-friendly empty state messaging
 **Delete All** - Debug feature to clear all data

### Comments
 **Dedicated View** - Modal sheet for viewing and adding comments
 **Real-time Updates** - Comments appear immediately after posting
 **Independent Sections** - Each post has its own comment thread
 **Timestamps** - Relative time display (e.g., "2 hours ago")
 **Auto-focus** - Keyboard appears automatically for quick commenting

### Data Persistence
 **Core Data Integration** - Local SQLite database
 **Persistent Storage** - All data survives app restarts
 **Relationship Management** - Proper Post-Comment relationships
 **Optimized Queries** - Efficient fetch requests with predicates



### Prerequisites

- **Xcode 26.0.1**
- **iOS 16.0+ SDK**


### Installation

1. **Clone or Download** the project
   ```bash
   # If using Git
   git clone <repository-url>
   cd SocialFeedApp
   ```

2. **Open in Xcode**
   ```bash
   open SocialFeedApp.xcodeproj
   ```

3. **Build and Run**
   - Select a simulator or device (iOS 16.0+)
   - Press `Cmd + R` to build and run
   - Grant permissions when prompted

### First Launch

When you first run the app, you'll be asked to grant:
- **📸 Photo Library Access** - Required to select images for posts
- **📍 Location Access** - Optional, for automatic location tagging

---

## 📖 Usage Guide

### Creating a Post

1. Tap the **"Create"** tab at the bottom
2. Tap the photo placeholder to select an image
3. Enter a description in the text editor
4. **Location Options:**
   - Tap the location button 📍 to fetch current location automatically
   - Toggle "Enter location manually" to type a location
5. Tap **"Create Post"** button
6. Confirm success and automatically navigate to Feed

### Interacting with Posts

#### Like a Post
- Tap the ❤️ heart icon to like/unlike
- Heart fills red when liked
- Like count updates instantly

#### Comment on a Post
- Tap the 💬 comment icon to open comments
- Type your comment in the text field
- Tap the send button ➤
- Comment appears immediately in the list

#### Share a Post
- Tap the 📤 share icon
- See simulation confirmation alert
- *(Note: Real sharing not implemented as per requirements)*

### Viewing Comments

- Tap comment icon on any post
- View all comments with timestamps
- Add new comments
- Comments persist across app launches
- Each post has independent comment threads

### Deleting All Data (Debug Feature)

- Go to Feed tab
- Tap 🗑️ trash icon in top-right corner
- Confirm deletion
- All posts and comments will be removed
