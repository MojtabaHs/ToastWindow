//
//  ToastManager.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI
import UIKit

public typealias ToastID = UUID

public typealias DismissClosure = () -> Void

public final class ToastManager: Sendable {
    
    public init() { }
    
    @MainActor public func showToast<V: View>(content: V,
                                              duration: TimeInterval,
                                              isUserInteractionEnabled: Bool = true,
                                              onDismiss: (() -> Void)? = nil) {
        
        WindowManager.createToastWindow(content: content,
                                        duration: duration,
                                        id: ToastID(),
                                        isUserInteractionEnabled: isUserInteractionEnabled,
                                        onDismiss: onDismiss)
    }
    
    @MainActor public func showToast<V: View>(content: V,
                                              duration: TimeInterval?,
                                              id: ToastID = ToastID(),
                                              isUserInteractionEnabled: Bool = true,
                                              onDismiss: (() -> Void)? = nil) -> UUID {
        
        WindowManager.createToastWindow(content: content,
                                        duration: duration,
                                        id: id,
                                        isUserInteractionEnabled: isUserInteractionEnabled,
                                        onDismiss: onDismiss)
        return id
    }
    
    @MainActor public func showToast<V: View>(content: V,
                                              id: ToastID = ToastID(),
                                              isUserInteractionEnabled: Bool = true,
                                              onDismiss: DismissClosure? = nil) {
        
        WindowManager.createToastWindow(content: content,
                                        duration: nil,
                                        id: id,
                                        isUserInteractionEnabled: isUserInteractionEnabled,
                                        onDismiss: onDismiss)
    }
    
    @MainActor public func showToast<V: View>(content: V,
                                              id: ToastID = ToastID(),
                                              isUserInteractionEnabled: Bool = true) -> DismissClosure {
        
        WindowManager.createToastWindow(content: content,
                                        duration: nil,
                                        id: id,
                                        isUserInteractionEnabled: isUserInteractionEnabled,
                                        onDismiss: nil)
        
        // Pass back the dismiss action
        let dismissAction: () -> Void = {
            WindowManager.dismissToastWindow(id: id)
        }
        
        return dismissAction
    }
}
