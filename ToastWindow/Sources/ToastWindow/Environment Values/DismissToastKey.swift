//
//  DismissToastKey.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/11/25.
//

import SwiftUI

public typealias DismissToastClosure = (@Sendable (ToastID) -> Void)
public typealias DismissAllToastsClosure = (@Sendable () -> Void)

public extension EnvironmentValues {
    @Entry var dismissToast: DismissToastClosure = { id in
        Task { @MainActor in
            WindowManager.dismissToastWindow(id: id)
        }
    }
    @Entry var dismissAllToasts: DismissAllToastsClosure = {
        Task { @MainActor in
            WindowManager.dismissAllToastWindows()
        }
    }
}
