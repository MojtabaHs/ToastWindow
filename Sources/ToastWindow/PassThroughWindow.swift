//
//  PassThroughWindow.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import UIKit

/// A specialized UIWindow that allows touch events to pass through to windows below it.
/// This window is used to display toast notifications without interfering with the main  application window.
///
/// - Discussion:
///   The PassThroughWindow is designed to be transparent to user interaction, allowing touches
///   to pass through to the underlying windows.
///
/// - Note:
///   This window is automatically managed by the ToastManager and should not be instantiated directly.
public final class PassThroughWindow: UIWindow {
    
    /// Initializes a new PassThroughWindow with the specified window scene.
    ///
    /// - Parameter windowScene: The window scene to associate with this window.
    public override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
    }
    
    /// Returns whether the window should handle the specified point for hit testing.
    ///
    /// - Parameters:
    ///   - point: The point to test.
    ///   - event: The event that triggered the hit test.
    /// - Returns: `false` to allow touch events to pass through to windows below.
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let vc = self.rootViewController else {
            return nil
        }
        for subview in vc.view.subviews {
            if subview.isUserInteractionEnabled,
               subview.frame.contains(point) {
                return subview
            }
        }
        return nil
    }
    
    /// Not implemented.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
