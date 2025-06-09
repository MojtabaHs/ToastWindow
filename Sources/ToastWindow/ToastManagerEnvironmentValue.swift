//
//  ToastManagerKey.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI

/// A custom environment key for managing toast notifications within SwiftUI.
/// This key allows global access to a shared `ToastManager` instance.
public struct ToastManagerKey: EnvironmentKey {
    /// The default instance of `ToastManager` used when no explicit value is set.
    public static let defaultValue: ToastManager = ToastManager()
}

public extension EnvironmentValues {
    /// Accessor for the `ToastManager` instance via the SwiftUI environment.
    var toastManager: ToastManager {
        get { self[ToastManagerKey.self] }
        set { self[ToastManagerKey.self] = newValue }
    }
}

