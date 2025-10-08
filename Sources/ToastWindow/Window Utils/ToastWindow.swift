//
//  ToastWindow.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/11/25.
//

import UIKit

/// A structure that represents a toast window and its associated dismiss callback.
///
/// The `ToastWindow` struct encapsulates a UIWindow instance and an optional dismiss callback
/// that will be called when the toast is dismissed.
struct ToastWindow {
    /// The UIWindow instance that displays the toast content.
    let window: UIWindow
    /// An optional closure that will be called when the toast is dismissed.
    let onDismiss: (() -> ())
}
