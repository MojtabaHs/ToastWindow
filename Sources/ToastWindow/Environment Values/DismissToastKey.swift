//
//  DismissToastKey.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/11/25.
//

import SwiftUI

/// Type alias for a closure that dismisses a specific toast by its ID.
public typealias DismissToastClosure = (@Sendable (ToastID) -> Void)
/// Type alias for a closure that dismisses all active toasts.
public typealias DismissAllToastsClosure = (@Sendable () -> Void)

public extension EnvironmentValues {
    /// A closure that dismisses a specific toast by its ID.
    ///
    /// This environment value provides a closure that can be used to dismiss a specific toast
    /// by its unique identifier. The dismissal is performed on the main actor to ensure thread safety.
    @Entry var dismissToast: DismissToastClosure = { id in
        Task { @MainActor in
            WindowManager.dismissToastWindow(id: id)
        }
    }
    
    /// A closure that dismisses all active toasts.
    ///
    /// This environment value provides a closure that can be used to dismiss all currently
    /// active toast notifications. The dismissal is performed on the main actor to ensure thread safety.
    @Entry var dismissAllToasts: DismissAllToastsClosure = {
        Task { @MainActor in
            WindowManager.dismissAllToastWindows()
        }
    }
}
