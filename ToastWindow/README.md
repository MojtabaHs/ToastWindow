# ToastWindow

[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Platform](https://img.shields.io/badge/platform-iOS-blue.svg)](https://developer.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)

A lightweight SwiftUI package for displaying toast notifications in iOS applications. ToastWindow creates a secondary window to display toast notifications, ensuring they appear above all other content while maintaining a clean and modern look using any SwiftUI view you pass in.

## Features

- 🪽 **SwiftUI Toast Views**
- 🖌️ Fully customizable using **SwiftUI Modifiers**
    - 🖼️ **Icons & Images** – Enables adding symbols or images in the toast message
    - 🎨 **Themes & Styling** – Allows color, typography, shadow, and rounded corner customization
    - 🎭 **Customizable Animations** – Build animations using SwiftUI Modifiers
    - ✋ **Gesture Handling** – Enable **touch and swipe** gestures, such as dismissing by tap or swipe
- 📌 **Positioning Control**
    - **Displays on top of everything** including sheets from the `.sheet` SwiftUI modifier
    - **Support for top, bottom, or center placements**
    - **Support for custom offsets**
- 🔀 Support for **multiple simultaneously displayed toasts**
    - **Optionally manage multiple toast messages** in sequence with a Y-axis offset value
    - **Does not affect middle position toasts**
- 🧠 **Efficient Memory Management**
    - 🔄 **Automatic window management**
    - ☔️ **Avoid retaining toasts or UIWindows indefinitely** to prevent memory leaks
- 🔒 **Thread Safety** – Ensures **UI updates occur on the main thread**
- ⏱️ **Customizable Duration** 
    - Be sure to include animation duration in the total duration
    
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
                content: Text("Hello, World!"),
                duration: 2.0
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
                // Animation duration is 0.3, be sure to include this in your toast duration time!
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
    content: MyToastView(message: "Form Submitted!", duration: 2.0),
    duration: 2.6, // Be sure to include animation duration time! (2.0 + (2 * 0.3))
)
```

### Multiple Toasts

```swift
// Configure the manager to display multiple toasts with an offset
let toastManager = ToastManager(multiToastOffset: 60)

// Show multiple toasts
toastManager.showToast(
    content: Text("Top toast"),
    duration: 2.0,
    position: .top
)
toastManager.showToast(
    content: Text("Bottom toast"),
    duration: 2.0,
    position: .bottom
)
toastManager.showToast(
    content: Text("Second bottom toast"),
    duration: 2.0,
    position: .bottom
)
```

------

## API Reference

### ToastManager

The main class for managing toast notifications.

```swift
public class ToastManager {
    public init(multiToastOffset: CGFloat? = nil)
    
    public func configure(multiToastOffset: CGFloat?)
    
    public func showToast<V: View>(
        content: V,
        duration: TimeInterval,
        position: ToastPosition = .bottom,
        offsetY: CGFloat = 100
    )
}
```

### ToastPosition

Enum defining the possible positions for toast notifications.

```swift
public enum ToastPosition {
    case top
    case middle
    case bottom
}
```

------

## Screenshots

<!-- Add screenshots here -->
![Toast Example](Screenshots/toast-example.png)
![Multiple Toasts](Screenshots/multiple-toasts.png)

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
    - Icons & Images: Enables adding symbols or images alongside the toast message
    - Themes & Styling: Allows color, typography, shadow, and rounded corner customization
    - Custom Animations: Support fade-in, slide, bounce, or other effects for appearing/disappearing
    - Gesture Handling: Enable touch and swipe gestures, such as dismissing by tap or swipe
- Customizable Duration: For both animation and total display duration
- Positioning Control: Support placements like top, bottom, center, or custom offsets. 
- Thread Safety: Ensures UI updates occur on the main thread
- Memory Management: Avoid retaining toasts indefinitely or creating multiple UIWindows to prevent memory leaks
- Queue Handling: Optionally manage multiple toast messages in sequence with a Y axis Offset value 
    - Does not affect middle position toasts

---

### TODO: 
- Implement keyboard avoidance
- Allow infinite duration
- Configure movement for toasts 
    - Allow draggin
    - Enable placement change (e.g. multiple toasts move down when first pops FIFO)
    
