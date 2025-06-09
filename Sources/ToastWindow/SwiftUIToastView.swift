//
//  SwiftUIToastView.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import UIKit
import SwiftUI
public class SwiftUIToastView: UIView {
    init<V: View>(content: V,
                  duration: TimeInterval = 2.0,
                  animationDuration: TimeInterval = 0.3,
                  parentWindow: UIWindow) {
        
        super.init(frame: .zero)
        
        // Embed SwiftUI View inside UIHostingController
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(hostingController.view)

        // Use `sizeThatFits` to get SwiftUI view's intrinsic size
        let size = hostingController.view.sizeThatFits(CGSize(width: parentWindow.frame.width - 40, height: .greatestFiniteMagnitude))
        
        // Set the frame dynamically based on SwiftUI view's size
        frame = CGRect(x: parentWindow.frame.width / 2 - size.width / 2,
                       y: parentWindow.frame.height - size.height - 100,
                       width: size.width,
                       height: size.height)
        
        // Apply constraints to match intrinsic size
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        // Schedule removal after display duration + animation in/out time
        let displayDuration: DispatchTime = .now() + duration + (animationDuration * 2)
        DispatchQueue.main.asyncAfter(deadline: displayDuration) { [weak self] in
            self?.removeFromSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
