//
//  DismissToastKey.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/11/25.
//

import SwiftUI

public typealias DismissToastClosure = (@Sendable (UUID) -> Void)?

struct DismissToastKey: EnvironmentKey {
    static let defaultValue: DismissToastClosure = nil
}

public extension EnvironmentValues {
    var dismissToast: DismissToastClosure {
        get { self[DismissToastKey.self] }
        set { self[DismissToastKey.self] = newValue }
    }
}
