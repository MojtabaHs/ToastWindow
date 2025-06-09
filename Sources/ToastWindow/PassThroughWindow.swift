//
//  PassThroughWindow.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import UIKit

/// This class handles allowing passing user interaction events through to the desired UIWindow.
final class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        // Check if toast was tapped
        if let hitView,
           hitView.window == self {
            // Toast was tapped
            return hitView
        } else {
            // Pass hit through to main/key window
            return nil
        }
    }
}
