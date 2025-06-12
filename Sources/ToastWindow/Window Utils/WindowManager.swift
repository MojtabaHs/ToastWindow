//
//  WindowManager.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/10/25.
//

import UIKit
import SwiftUI

/// A manager class that handles the creation and management of toast windows.
///
/// The `WindowManager` is responsible for creating, tracking, and dismissing toast windows.
/// It maintains a dictionary of active toast windows and provides methods to manage their lifecycle.
@MainActor enum WindowManager {
    
    private static var toastWindows: [ToastID: ToastWindow] = [:]
        
    /// Creates a new toast window with the specified content and configuration.
    /// - Parameters:
    ///   - content: The SwiftUI view to display in the toast window.
    ///   - duration: Optional time interval after which the toast will automatically dismiss.
    ///   - id: Unique identifier for the toast window.
    ///   - isUserInteractionEnabled: Whether the toast window should respond to user interactions.
    ///   - onDismiss: Optional closure to be called when the toast is dismissed.
    static func createToastWindow<V: View>(content: V,
                                           duration: TimeInterval?,
                                           id: ToastID,
                                           isUserInteractionEnabled: Bool,
                                           onDismiss: (() -> ())?) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            assertionFailure("ToastWindow Error: Active UIWindowScene not found")
            return
        }

        let window = PassThroughWindow(windowScene: scene)
                
        
        let controller = UIHostingController(rootView: content)
        controller.view.backgroundColor = .clear

        window.isUserInteractionEnabled = isUserInteractionEnabled
        window.backgroundColor = .clear
        window.rootViewController = controller
        window.windowLevel = .alert + 1
        window.isHidden = false
        
        toastWindows[id] = ToastWindow(window: window,
                                       onDismiss: onDismiss)
        
        if let duration {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                dismissToastWindow(id: id)
            }
        }
    }
    
    /// Dismisses a specific toast window by its ID.
    /// - Parameter id: The unique identifier of the toast window to dismiss.
    static func dismissToastWindow(id: ToastID) {
        guard let toast = toastWindows[id] else {
            return
        }
        
        toast.onDismiss?()
        toast.window.isHidden = true
        toast.window.rootViewController = nil
        toast.window.removeFromSuperview()
        toast.window.windowScene = nil
        toastWindows.removeValue(forKey: id)
    }
    
    /// Dismisses all active toast windows.
    static func dismissAllToastWindows() {
        for (_, toast) in toastWindows {
            toast.onDismiss?()
            toast.window.isHidden = true
            toast.window.rootViewController = nil
            toast.window.removeFromSuperview()
            toast.window.windowScene = nil
        }
        toastWindows = [:]
    }
}
