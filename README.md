# Features:  
  - Main Screen has two tabs: Home and Search.
  * <ins>Home View</ins>:
      - Fetch **home sections** and their details.
      - Support multiple **display modes**: square, bigSquare, twoLinesGrid, and queue.
      - Tap on a card to view its **description** (UIKit) and **navigate** to the website for the full content (if there is a link).

  * <ins>Search View</ins>:
    - Implement **search** functionality with result display.
    - Start searching after a **200ms debounce delay**

  - For both:
    - Handle multiple **loading state** (loading, empty, error, and done) to show content according to the state (progress view, empty view, error view, and content view).   
    - Use **Swift Concurrency (Async/Await)** for api calls.
    - **Image loader** component to load image.
    - Apply **app fonts**.
    - Include **unit tests** for core logic.
    - Add **UI tests** for key interface components.
    - Use `SwiftUI` mainly and `UIKit` for the description bottom sheet.

# Requirements:
  - Xcode Version: 16.3.
  - iOS Deployment Target: +15.6.
  - Swift Version: 5.

# Architecture:
  - Clean Architecture and MVVM.

```bash
PodcastApp
├── Data
│   ├── DTO
│   │   └── Responses
│   ├── Mappers
│   ├── Network
│   └── Repository
│
├── Domain
│   ├── Entities
│   ├── Enums
│   ├── Extension
│   ├── Repository
│   └── UseCases
│
├── Network
│
├── Presentation
│   ├── View
│   └── ViewModel
│
└── Resources
    ├── AppFonts
    └── Assets

PodcastAppTests
PodcastAppUITests
```


# Screenshots:
  - Home View:
    
    <img src="PodcastApp/Resources/Assets.xcassets/OutputScreenshots/Home_DisplayType1.imageset/Home_DisplayType1.png" alt="Home_DisplayType1" width="300"/>
    
    <img src="PodcastApp/Resources/Assets.xcassets/OutputScreenshots/Home_DisplayType2.imageset/Home_DisplayType2.png" alt="Home_DisplayType2" width="300"/>
    
    <img src="PodcastApp/Resources/Assets.xcassets/OutputScreenshots/Home_DisplayType3.imageset/Home_DisplayType3.png" alt="Home_DisplayType3" width="300"/>
    
    <img src="PodcastApp/Resources/Assets.xcassets/OutputScreenshots/Home_DisplayType4.imageset/Home_DisplayType4.png" alt="Home_DisplayType4" width="300"/>


  - Search View:
    
    <img src="PodcastApp/Resources/Assets.xcassets/OutputScreenshots/Empty_Search.imageset/Empty_Search.png" alt="Empty_Search" width="300"/>
    
    <img src="PodcastApp/Resources/Assets.xcassets/OutputScreenshots/Search_Results.imageset/Search_Results.png" alt="Search_Results" width="300"/>
    
  - Description Bottom Sheet:

    <img src="PodcastApp/Resources/Assets.xcassets/OutputScreenshots/Description_Bottom_Sheet.imageset/Description_Bottom_Sheet.png" alt="Description_Bottom_Sheet" width="300"/>

    <img src="PodcastApp/Resources/Assets.xcassets/OutputScreenshots/Description_Link.imageset/Description_Link.png" alt="Description_Link" width="300"/>


