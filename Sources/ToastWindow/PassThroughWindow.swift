//
//  PassThroughWindow.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import UIKit

final class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        
        // Check if toast was tapped
        if let hitView,
           hitView.isKind(of: UIToastView.self)  {
            return hitView
        } else {
            // Pass hit through to main window
            return nil
        }
    }
}
