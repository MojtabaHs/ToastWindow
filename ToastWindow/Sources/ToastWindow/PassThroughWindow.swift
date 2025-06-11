//
//  PassThroughWindow.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import UIKit
import SwiftUI

@MainActor
public final class WindowManager {
    
    var windows: [UUID: UIWindow] = [:]
    
    /// Returns the app's Key Window
    private var activeWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }

    // Show a new window with hosted SwiftUI content
    public func showInNewWindow<Content: View>(id: UUID = UUID(),
                                               allowTapThrough: Bool,
                                               dismissClosure: @escaping ()->(),
                                               content: @escaping () -> Content) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            assertionFailure("No valid scene available")
            return
        }

        let window = allowTapThrough ? PassThroughWindow(windowScene: scene) : UIWindow(windowScene: scene)
        window.backgroundColor = .clear

        let controller = UIHostingController(rootView: content())
        controller.view.backgroundColor = .clear
        window.rootViewController = controller
        window.windowLevel = .alert + 1
        window.makeKeyAndVisible()

        windows[id] = window
    }

    func closeWindow(id: UUID) {
        windows[id]?.isHidden = true
        windows.removeValue(forKey: id)
    }
}


/// A specialized UIWindow that allows touch events to pass through to windows below it.
/// This window is used to display toast notifications without interfering with the main  application window.
///
/// - Discussion:
///   The PassThroughWindow is designed to be transparent to user interaction, allowing touches
///   to pass through to the underlying windows.
///
/// - Note:
///   This window is automatically managed by the ToastManager and should not be instantiated directly.
public final class PassThroughWindow: UIWindow {
    
    /// Initializes a new PassThroughWindow with the specified window scene.
    ///
    /// - Parameter windowScene: The window scene to associate with this window.
    public override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
    }
 
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let vc = self.rootViewController {
            vc.view.layoutSubviews() // otherwise the frame is as if the popup is still outside the screen
            if let _ = isTouchInsideSubview(point: point, view: vc.view) {
                // pass tap to this UIPassthroughVC
                return vc.view
            }
        }
        return nil // pass to next window
    }

    private func isTouchInsideSubview(point: CGPoint, view: UIView) -> UIView? {
        for subview in view.subviews {
            if subview.isUserInteractionEnabled, subview.frame.contains(point) {
                return subview
            }
        }
        return nil
    }
    
    /// Not implemented.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
