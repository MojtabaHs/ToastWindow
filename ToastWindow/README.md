# ToastWindow

[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)

A lightweight SwiftUI package for displaying toast notifications in iOS applications. ToastWindow creates a secondary window to display toast notifications, ensuring they appear above all other content while maintaining a clean and modern look using any SwiftUI view you pass in.
    
------

## Installation

### Swift Package Manager

Add the following dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/michael94ellis/ToastWindow.git", from: "1.0.0")
]
```

Or add it directly in Xcode:

1. Go to File > Add Packages...
2. Enter the repository URL below and then click Add Package

```
https://github.com/michael94ellis/ToastWindow.git
```

------

## Usage

### Basic Usage

```swift
import SwiftUI
import ToastWindow

struct ContentView: View {

    @Environment(\.toastManager) var toastManager
    
    var body: some View {
        Button("Show Toast") {
            toastManager.showToast(
                content: Text("Hello, World!")
            )
        }
    }
}
```

### Custom Toast Content

```swift

struct MyToastView: View {
    let message: String
    let duration: TimeInterval = 2.0
    @State private var isVisible = false
    @State private var offset: CGFloat = 50.0

    var body: some View {
        Text(message)
            .padding()
            .background(Color.red.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(8)
            .offset(y: offsetY)
            .opacity(isVisible ? 1 : 0)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isVisible = true 
                    offset = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    withAnimation(.easeInOut(duration: 0.3)) { 
                        offset = 50
                        isVisible = false 
                    }
                }
            }
    }
}

// Programmatically invoke toast presentation
toastManager.showToast(
    content: MyToastView(message: "Form Submitted!")
)
```

### Multiple Toasts

```swift
// Show multiple toasts
toastManager.showToast(
    content: 
        VStack {
            Spacer() 
            Text("Top toast")
        }
)
toastManager.showToast(
    content: 
        VStack {
            Spacer() 
            Text("Middle toast")
            Spacer()
        }
)
toastManager.showToast(
    content: 
        VStack {
            Spacer() 
            Text("Bottom toast")
        }
)
```

------

## Requirements

- iOS 13.0+
- Swift 6.0+
- Xcode 14.0+

## License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details.

## Contributing

Contributions are welcome! Please feel free to Fork and submit a Pull Request.

## Author

Michael Ellis

## Acknowledgments

- Inspired by various toast notification implementations
- Additional thanks to these sources
    - https://stackoverflow.com/questions/14740921/passing-touches-between-stacked-uiwindows
    - https://www.fivestars.blog/articles/swiftui-windows/

# Features

## UI

- SwiftUI Compatibility
    - Positioning Control: Support placements like top, bottom, center, or custom offsets
    - Icons & Images: Enables adding symbols or images alongside the toast message
    - Themes & Styling: Allows color, typography, shadow, and rounded corner customization
    - Custom Animations: Support fade-in, slide, bounce, or other effects for appearing/disappearing
    - Gesture Handling: Enable touch and swipe gestures, such as dismissing by tap or swipe
- Customizable Duration: For both animation and total display duration
- Thread Safety: Ensures UI updates occur on the main thread
- Memory Management: Avoid retaining UIWindows indefinitely to prevent memory leaks

---

### TODO: 
- Implement keyboard avoidance
- Configure movement for toasts 
    - Enable placement change (e.g. multiple toasts move down when first pops FIFO)
    
