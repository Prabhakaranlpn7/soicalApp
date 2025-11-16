# 📱 Social Media Feed App — SwiftUI + Core Data (MVVM)

A fully-featured **iOS social media feed application** built with **SwiftUI**, **Core Data**, and a clean **MVVM architecture**. It supports creating posts with images, descriptions, and locations, along with rich interactions such as likes, comments, and share simulation.

---

## 🖼️ Screenshots

> *(Replace image placeholders with actual image links)*

| Create Post | Feed | Comments | Location |
|-------------|-------|-----------|-----------|
| ![Create](IMAGE_URL) | ![Feed](https://github.com/user-attachments/assets/3396bf88-b3e1-4872-bc44-37f783cb9519) | ![Comments](IMAGE_URL) | ![Location](IMAGE_URL) |


---

## 🚀 Features

### 📝 Create Post
- Select images using **PhotosPicker**
- Rich text editor for post description
- **Automatic location fetching** using CoreLocation
- Manual location entry fallback
- Smart form validation and alerts
- Permission handling for location & photos

### 📰 Feed View
- Smooth scrolling using `LazyVStack`
- Displays image, description, timestamp, and location
- Like system with animated heart toggle ❤️
- Comment sheet for post-specific comment threads
- Share simulation alert
- Pull-to-refresh
- Empty state UI
- Delete-all option for debug

### 💬 Comment System
- Dedicated modal sheet view
- Instant updates on adding comments
- Independent comment threads per post
- Relative timestamps (e.g., "2 hours ago")
- Auto-focus keyboard for quick typing

### 💾 Data Persistence (Core Data)
- Local SQLite-backed storage
- Posts & Comments with proper relationships
- Efficient fetch requests with predicates
- Persistent across app launches

---

## 🛠️ Tech Stack

| Component | Technology |
|----------|------------|
| UI | SwiftUI |
| Architecture | MVVM |
| Database | Core Data |
| Async | `async/await`, `@MainActor` |
| Permissions | PhotosPicker, CoreLocation |
| OS Support | iOS 16.0+ |
| IDE | Xcode 16+ |

---

## 📐 Architecture Overview

```
App
 ├── Models
 │     ├── PostEntity (Core Data)
 │     └── CommentEntity
 │
 ├── ViewModels
 │     ├── FeedViewModel
 │     ├── CreatePostViewModel
 │     └── CommentViewModel
 │
 ├── Views
 │     ├── FeedView
 │     ├── CreatePostView
 │     └── CommentSheetView
 │
 └── CoreData
       └── PersistenceController
```

---

## 📦 Installation

### 1️⃣ Clone the Repository
```bash
git clone <repository-url>
cd SocialFeedApp
```

### 2️⃣ Open the Project
```bash
open SocialFeedApp.xcodeproj
```

### 3️⃣ Build & Run
- Select iOS 16.0+ simulator
- Press **Cmd + R**
- Allow permissions when prompted

---

## 📖 Usage

### ✨ Creating a Post
1. Open the **Create** tab
2. Tap image section to pick a photo
3. Type a description
4. Fetch or manually enter location
5. Tap **Create Post**

### ❤️ Interacting with Feed
- Tap ❤️ to like/unlike a post
- Tap 💬 to open comments
- Tap 📤 for share simulation

### 💬 Managing Comments
- Add comments with auto-focus
- View comment threads per post
- Timestamps show relative time

### 🗑️ Debug: Delete All Data
- Open Feed tab
- Tap the trash icon (top-right)
- Confirm deletion

---

## 🔮 Future Enhancements
- Real sharing with UIActivityViewController
- CloudKit sync
- Offline caching improvements
- Dark Mode UI polish
- Hashtag detection
- User profile system

---

## 📄 License
This project is provided for educational and portfolio purposes. You may modify and use it freely.
