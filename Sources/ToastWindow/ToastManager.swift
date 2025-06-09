//
//  ToastManager.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI
import UIKit

/// This class handles setting up a secondary UIWindow and displaying Toast UIViews in the secondary window on top of the Key Window that app content is in
@MainActor final public class ToastManager {
    
    /// The secondary UIWindow that toasts are displayed
    private var toastWindow: PassThroughWindow?
    
    /// Returns the app's Key Window
    private var activeWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    public func showToast<V: View>(content: V,
                                   duration: TimeInterval = 2.0,
                                   animationDuration: TimeInterval = 0.3) {
        guard let window = activeWindow,
              let scene = window.windowScene else {
            assertionFailure("Failed to retrieve active window")
            return
        }
        
        // Setup toast window if necessary, else do nothing
        if toastWindow == nil {
            let toastWindow = PassThroughWindow(windowScene: scene)
            toastWindow.windowLevel = .alert + 1
            toastWindow.backgroundColor = UIColor.clear
            self.toastWindow = toastWindow
        }
        
        guard let toastWindow else {
            assertionFailure("Failed to setup toast window")
            return
        }
        
        let toastUIView = SwiftUIToastView(content: content,
                                           duration: duration,
                                           animationDuration: animationDuration,
                                           parentWindow: toastWindow)
        toastWindow.isHidden = false
        toastWindow.isUserInteractionEnabled = true
        toastWindow.addSubview(toastUIView)
        toastWindow.bringSubviewToFront(toastUIView)
    }
}
