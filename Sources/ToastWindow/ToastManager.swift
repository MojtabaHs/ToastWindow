//
//  ToastManager.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import UIKit

@MainActor
final class ToastManager {
    
    private var toastWindow: UIWindow?
    
    private var activeWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    private func setupToastWindow(in scene: UIWindowScene) {
        if toastWindow == nil {
            let toastWindow = PassThroughWindow(windowScene: scene)
            toastWindow.windowLevel = .alert + 1
            toastWindow.backgroundColor = UIColor.clear
            self.toastWindow = toastWindow
        }
    }
    
    private func setupToastView(in window: UIWindow, with message: String) {
        
        let uiView = UIToastView(message: message,
                                  parentWindow: window)
        window.addSubview(uiView)
        window.windowLevel = .alert + 1
        window.isHidden = false
        window.bringSubviewToFront(uiView)
        window.isUserInteractionEnabled = true
    }
    
    func showToast(message: String,
                   duration: TimeInterval = 2.0) {
        
        guard let window = activeWindow,
           let scene = window.windowScene else {
            assertionFailure("Failed to retrieve active window")
            return
        }
        
        setupToastWindow(in: scene)
        
        guard let toastWindow else {
            assertionFailure("Failed to setup toast window")
            return
        }
        
        setupToastView(in: toastWindow, with: message)
        
    }
}
