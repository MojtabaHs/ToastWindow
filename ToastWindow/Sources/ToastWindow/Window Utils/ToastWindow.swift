//
//  ToastWindow.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/11/25.
//

import UIKit

struct ToastWindow {
    let window: UIWindow
    let onDismiss: (() -> ())?
}
