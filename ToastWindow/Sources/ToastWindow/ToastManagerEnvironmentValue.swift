//
//  ToastManagerEnvironmentValue.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI

/// A SwiftUI environment key for accessing the ToastManager instance throughout the view hierarchy.
///
/// - Discussion:
///   This environment key allows you to access the ToastManager from any view in your SwiftUI hierarchy
///   without explicitly passing it through the view hierarchy. This is particularly useful for
///   displaying toasts from deeply nested views.
///
/// - Example:
/// ```swift
/// struct ContentView: View {
///     @Environment(\.toastManager) private var toastManager
///     
///     var body: some View {
///            ...
///     }
/// }
/// ```
public struct ToastManagerKey: EnvironmentKey {
    /// The default instance of `ToastManager` used when no explicit value is set.
    public static let defaultValue = ToastManager()
}

public extension EnvironmentValues {
    /// The ToastManager instance available in the environment.
    ///
    /// - Discussion:
    ///   Use this property to access the ToastManager from any view in your SwiftUI hierarchy.
    var toastManager: ToastManager {
        get { self[ToastManagerKey.self] }
        set { self[ToastManagerKey.self] = newValue }
    }
}

