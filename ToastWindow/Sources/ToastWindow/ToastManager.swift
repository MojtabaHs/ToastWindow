//
//  ToastManager.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI
import UIKit

public final class ToastManager: Sendable {
    
    public init() { }

    // Show a new window with hosted SwiftUI content
    @MainActor public func showToast<V: View>(content: V,
                                              id: UUID = UUID(),
                                              isUserInteractionEnabled: Bool = true) {
        WindowManager.createToastWindow(content: content,
                                        id: id,
                                        isUserInteractionEnabled: isUserInteractionEnabled)
    }
}
