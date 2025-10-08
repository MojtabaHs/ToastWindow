//
//  ToastManager.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI
import UIKit

public typealias ToastID = UUID

public typealias DismissClosure = () -> Void

/// A manager class that delegates the creation and display of toast notifications in a separate window.
///
/// The `ToastManager` class provides methods to show toast notifications with various configurations,
/// including duration, user interaction settings, and dismiss callbacks.
public final class ToastManager: Sendable {
    
    public init() { }
    
    /// Shows a toast notification with the specified content and duration, returning its ID.
    /// - Parameters:
    ///   - content: The SwiftUI view to display in the toast.
    ///   - duration: The time interval after which the toast will automatically dismiss.
    ///               Passing `nil` causes the toast remains visible until manually dismissed.
    ///               The default value is `2.5`.
    ///   - id: A unique identifier for the toast. If not provided, a new UUID will be generated.
    ///   - isUserInteractionEnabled: Whether the toast should respond to user interactions.
    ///   - onDismiss: A closure to be called when the toast is dismissed.
    /// - Returns: The unique identifier of the created toast which can be used to dismiss it.
    @discardableResult
    @MainActor public func showToast<V: View>(content: V,
                                              duration: TimeInterval? = 2.5,
                                              id: ToastID = ToastID(),
                                              isUserInteractionEnabled: Bool = true,
                                              onDismiss: (() -> Void)? = nil) -> UUID {
        
        WindowManager.createToastWindow(content: content,
                                        duration: duration,
                                        id: id,
                                        isUserInteractionEnabled: isUserInteractionEnabled,
                                        onDismiss: onDismiss)
        return id
    }
    
    /// Shows a toast notification with the specified content and returns a closure to dismiss it.
    /// - Parameters:
    ///   - content: The SwiftUI view to display in the toast.
    ///   - id: A unique identifier for the toast. If not provided, a new UUID will be generated.
    ///   - isUserInteractionEnabled: Whether the toast should respond to user interactions.
    /// - Returns: A closure that can be called to dismiss the toast.
    @MainActor public func showToast<V: View>(content: V,
                                              id: ToastID = ToastID(),
                                              isUserInteractionEnabled: Bool = true) -> DismissClosure {
        
        WindowManager.createToastWindow(content: content,
                                        duration: nil,
                                        id: id,
                                        isUserInteractionEnabled: isUserInteractionEnabled,
                                        onDismiss: nil)
        
        // Pass back the dismiss action
        let dismissAction: () -> Void = {
            WindowManager.dismissToastWindow(id: id)
        }
        
        return dismissAction
    }
}
