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
                  duration: TimeInterval,
                  parentWindow: UIWindow,
                  position: ToastPosition = .bottom,
                  offsetY: CGFloat = 100) {
        
        super.init(frame: .zero)
        
        // Embed SwiftUI View inside UIHostingController
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Insert the SwiftUI view into the UIView
        addSubview(hostingController.view)

        // Set size of view container to ToastWindow's size
        let size = hostingController.view.sizeThatFits(parentWindow.frame.size)

        // Add view to parent window
        parentWindow.addSubview(self)
        
        // Enable auto-layout
        translatesAutoresizingMaskIntoConstraints = false

        // Apply width constraints to match SwiftUI intrinsic size
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height),
            centerXAnchor.constraint(equalTo: parentWindow.centerXAnchor)
        ])
        
        // Configure vertical positioning
        switch position {
        case .top:
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: parentWindow.topAnchor, constant: offsetY)
            ])
        case .middle:
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: parentWindow.centerYAnchor)
            ])
        case .bottom:
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: parentWindow.bottomAnchor, constant: -offsetY)
            ])
        }

        // Schedule removal after display duration + animation in/out time
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.removeFromSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
