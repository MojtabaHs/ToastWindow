//
//  PassThroughWindow.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import UIKit
import SwiftUI

/// A custom UIWindow subclass that allows touch events to pass through to underlying windows
/// unless they intersect with interactive views in the toast content.
///
/// This window type is used to ensure that toast notifications don't block interaction with
/// the main application window unless the user is specifically interacting with the toast content.
final class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        guard isUserInteractionEnabled,
              let vc = self.rootViewController else {
            return nil
        }
        
        vc.view.layoutIfNeeded()
        
        guard let _ = vc.view.subviews.first(where: { subview in
            subview.isUserInteractionEnabled && subview.frame.contains(point)
        }) else {
            return nil
        }
        
        return vc.view
    }
}
