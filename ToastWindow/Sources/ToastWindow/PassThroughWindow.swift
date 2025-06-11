//
//  PassThroughWindow.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import UIKit
import SwiftUI

class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard isUserInteractionEnabled,
              let vc = self.rootViewController else {
            return nil
        }
        vc.view.layoutIfNeeded()
        guard vc.view.subviews.contains(where: { subview in
            subview.isUserInteractionEnabled && subview.frame.contains(point)
        }) else {
            return nil
        }
        return vc.view
    }
}
