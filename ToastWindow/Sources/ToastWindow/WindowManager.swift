//
//  WindowManager.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/10/25.
//

import UIKit
import SwiftUI

struct ToastWindow {
    let window: UIWindow
    let onDismiss: (() -> ())?
}

@MainActor enum WindowManager {
        
    private static var toastWindows: [UUID: ToastWindow] = [:]
        
    static func createToastWindow<V: View>(content: V,
                                           duration: TimeInterval?,
                                           id: UUID = UUID(),
                                           isUserInteractionEnabled: Bool,
                                           onDismiss: (() -> ())?) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            assertionFailure("ToastWindow Error: Active UIWindowScene not found")
            return
        }
        
        let window = PassThroughWindow(windowScene: scene)
                
        let controller = UIHostingController(rootView: content)
        controller.view.backgroundColor = .clear
        
        window.isUserInteractionEnabled = isUserInteractionEnabled
        window.backgroundColor = .clear
        window.rootViewController = controller
        window.windowLevel = .alert + 1
        window.makeKeyAndVisible()
        
        toastWindows[id] = ToastWindow(window: window,
                                       onDismiss: onDismiss)
        
        if let duration {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                dismissToastWindow(id: id)
            }
        }
    }
    
    static func dismissToastWindow(id: UUID) {
        guard let toast = toastWindows[id] else {
            return
        }
        
        toast.onDismiss?()
        toast.window.isHidden = true
        toast.window.rootViewController = nil
        toast.window.removeFromSuperview()
        toast.window.windowScene = nil
        toastWindows.removeValue(forKey: id)
    }
    
    static func dismissAllToastWindows() {
        for (_, toast) in toastWindows {
            toast.onDismiss?()
            toast.window.isHidden = true
            toast.window.rootViewController = nil
            toast.window.removeFromSuperview()
            toast.window.windowScene = nil
        }
        toastWindows = [:]
    }
}
