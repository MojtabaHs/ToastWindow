//
//  WindowManager.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/10/25.
//

import UIKit
import SwiftUI

@MainActor final class WindowManager {
    
    static let shared = WindowManager()
    
    private var windows: [UUID: UIWindow] = [:]
    
    init() { }
    
    static func createToastWindow<V: View>(content: V,
                                           id: UUID = UUID(),
                                           isUserInteractionEnabled: Bool = true) {
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
        
        shared.windows[id] = window
    }
    
    static func dismissToast(id: UUID) {
        shared.windows[id]?.isHidden = true
        shared.windows.removeValue(forKey: id)
    }
}
