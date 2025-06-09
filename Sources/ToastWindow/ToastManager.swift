//
//  ToastManager.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI
import UIKit

/// This class handles setting up a secondary UIWindow and displaying Toast UIViews in the secondary window on top of the Key Window that app content is in
final public class ToastManager: Sendable {
    
    /// The secondary UIWindow that toasts are displayed
    @MainActor
    private var toastWindows: [PassThroughWindow] = []
    
    /// Returns the app's Key Window
    @MainActor
    private var activeWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    public init() {}
    
    /// Displays a SwiftUI toast view inside a secondary UIWindow, overlaying the active window.
    ///
    /// - Parameters:
    ///   - content: The SwiftUI view to be displayed as a toast.
    ///   - duration: The time interval for which the toast remains visible.
    ///               Note: This value must be explicitly set; animation time should be included.
    ///   - position: The vertical placement of the toast, see `ToastWindow.ToastPosition` for values. Defaults to `.bottom`.
    ///   - offsetY: Additional vertical offset for fine-tuned positioning; useful for animations or UI adjustments.
    ///
    /// - Discussion:
    ///   This function manages a secondary window (`PassThroughWindow`) that temporarily displays a toast.
    ///   If no existing toast window is found, one is created.
    ///   The toast view is then inserted into this window and positioned based on the specified `position` and `offsetY`.
    ///   After `duration` elapses, the window is destroyed to free up resources.
    ///
    /// - Example Usage:
    /// ```swift
    /// ToastManager().showToast(
    ///     content: Text("Hello!"),
    ///     duration: 2.0,
    ///     position: .top,
    ///     offsetY: 50
    /// )
    /// ```
    ///
    /// - Warning:
    ///   If the active window cannot be retrieved, an assertion failure is triggered.
    ///   Ensure your app has an active `UIWindowScene` before invoking this method.
    @MainActor
    public func showToast<V: View>(content: V,
                                   duration: TimeInterval,
                                   position: ToastPosition = .bottom,
                                   offsetY: CGFloat = 100) {
        guard let window = activeWindow,
              let scene = window.windowScene else {
            assertionFailure("Failed to retrieve active window")
            return
        }
        
        let toastWindow = PassThroughWindow(windowScene: scene)
        toastWindow.windowLevel = .alert + 1
        toastWindow.backgroundColor = UIColor.clear
        self.toastWindows.append(toastWindow)
        
        let toastUIView = SwiftUIToastView(content: content,
                                           duration: duration,
                                           parentWindow: toastWindow,
                                           position: position,
                                           offsetY: offsetY)
        toastWindow.isHidden = false
        toastWindow.isUserInteractionEnabled = true
        toastWindow.addSubview(toastUIView)
        toastWindow.bringSubviewToFront(toastUIView)
        
        // Schedule window destruction after duration elapses
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            toastWindow.isHidden = true
            self?.toastWindows.removeAll(where: { $0 == toastWindow})
        }
    }
}
