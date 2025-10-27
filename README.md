
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
