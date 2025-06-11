//
//  ToastManager.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI
import UIKit

public typealias DismissClosure = () -> Void

public final class ToastManager: Sendable {
    
    public init() { }
    
    @discardableResult
    @MainActor public func showToast<V: View>(content: V,
                                              duration: TimeInterval?,
                                              id: UUID = UUID(),
                                              isUserInteractionEnabled: Bool = true,
                                              onDismiss: (() -> Void)? = nil) -> UUID {
        
        // Enable dismissing the Toast Window via environment key function call
        let dismissableContent = content
            .environment(\.dismissToast, { id in
                Task { @MainActor in
                    WindowManager.dismissToastWindow(id: id)
                }
            })
        
        WindowManager.createToastWindow(content: dismissableContent,
                                        duration: duration,
                                        id: id,
                                        isUserInteractionEnabled: isUserInteractionEnabled,
                                        onDismiss: onDismiss)
        return id
    }
    
    @discardableResult
    @MainActor public func showToast<V: View>(content: V,
                                              id: UUID = UUID(),
                                              isUserInteractionEnabled: Bool = true,
                                              onDismiss: DismissClosure? = nil) -> DismissClosure {
        
        WindowManager.createToastWindow(content: content,
                                        duration: nil,
                                        id: id,
                                        isUserInteractionEnabled: isUserInteractionEnabled)
        
        // Pass back the dismiss action
        let dismissAction: () -> Void = {
            WindowManager.dismissToastWindow(id: id)
        }
        
        return dismissAction
    }
}
