//
//  SwiftUIToastView.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import UIKit
import SwiftUI

/// A UIView subclass that hosts SwiftUI content for toast notifications.
///
/// - Discussion:
///   This class bridges SwiftUI views with UIKit for display in a secondary window.
///   It handles the layout and positioning of toast content, as well as automatic
///   removal after the specified duration.
///
/// - Note:
///   This class is used internally by ToastManager and should not be instantiated directly.
public final class SwiftUIToastView: UIView {
    
    /// The vertical position of the toast on the screen.
    let position: ToastPosition
    
    /// Initializes a new SwiftUIToastView with the specified content and configuration.
    ///
    /// - Parameters:
    ///   - content: The SwiftUI view to be displayed as a toast.
    ///   - duration: The time interval for which the toast remains visible.
    ///   - parentWindow: The window in which the toast will be displayed.
    ///   - position: The vertical placement of the toast. Defaults to `.bottom`.
    ///   - offsetY: Additional vertical offset for fine-tuned positioning. Defaults to 100.
    init<V: View>(content: V,
                  duration: TimeInterval,
                  parentWindow: UIWindow,
                  position: ToastPosition = .bottom,
                  offsetY: CGFloat = 100) {
        self.position = position
        super.init(frame: .zero)
        
        // Embed SwiftUI View inside UIHostingController
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Insert the SwiftUI view into the UIView
        addSubview(hostingController.view)

        // Set size of view container to ToastWindow's size
        let size = hostingController.view.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))

        // Add view to parent window
        parentWindow.addSubview(self)
        
        configureConstraints(size, parentWindow, position, offsetY)
        
        // Schedule removal after display duration + animation in/out time
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.removeFromSuperview()
        }
    }
    
    /// Configures the layout constraints for the toast view.
    ///
    /// - Parameters:
    ///   - size: The size of the toast content.
    ///   - parentWindow: The window containing the toast.
    ///   - position: The vertical position of the toast.
    ///   - offsetY: The vertical offset from the position.
    private func configureConstraints(_ size: CGSize,
                                      _ parentWindow: UIWindow,
                                      _ position: ToastPosition,
                                      _ offsetY: CGFloat) {
        // Enable auto-layout
        translatesAutoresizingMaskIntoConstraints = false
        
        // Apply width constraints to match SwiftUI intrinsic size
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height),
            centerXAnchor.constraint(equalTo: parentWindow.centerXAnchor)
        ])
        
        // Configure vertical positioning
        switch position {
        case .top:
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: parentWindow.topAnchor, constant: offsetY)
            ])
        case .middle:
            NSLayoutConstraint.activate([
                centerYAnchor.constraint(equalTo: parentWindow.centerYAnchor)
            ])
        case .bottom:
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: parentWindow.bottomAnchor, constant: -offsetY)
            ])
        }
    }
    
    required public init?(coder: NSCoder) {
        self.position = .bottom
        super.init(coder: coder)
    }
}
