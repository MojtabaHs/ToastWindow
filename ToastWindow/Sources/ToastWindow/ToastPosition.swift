//
//  ToastPosition.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

/// Defines the possible vertical positions for a toast notification.
/// Used to control where the toast appears on the screen.
///
/// - Cases:
///   - `top`: Positions the toast near the top of the screen.
///   - `middle`: Centers the toast in the middle of the screen.
///   - `bottom`: Places the toast near the bottom of the screen (default).
public enum ToastPosition {
    case top
    case middle
    case bottom
}
