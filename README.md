

# TODO List:

## UI

- SwiftUI Compatibility: Provide a declarative approach alongside UIKit integration. 
- Queue Handling: Manage multiple toast messages in sequence
- Handle device rotation: Ensure the toast doesn't get left behind if the device rotates
- Adaptive Sizing: Scale the toast based on text length and device screen dimensions.
- Customizable Duration: For both animation and total display duration
- User Interaction Handling: Enable touch gestures, such as dismissing by tap or swipe
- Safe Area Awareness: Don't overlap the status bar and other areas
- Accessibility Support: Ensure voiceover compatibility and dynamic font scaling.
- Custom Animations: Support fade-in, slide, bounce, or other effects for appearing/disappearing
- Dark Mode Support: Adjust styles dynamically based on the system appearance.
- Positioning Control: Support placements like top, bottom, center, or custom offsets. 
- Icons & Images: Enable adding symbols or images alongside the toast message.
- Themes & Styling: Allow color, typography, shadow, and rounded corner customization. 


## Concurrency
- Thread Safety: Ensure UI updates occur on the main thread
- Efficient Memory Management: Avoid retaining toasts indefinitely to prevent memory leaks
