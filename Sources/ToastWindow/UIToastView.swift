//
//  UIToastView.swift
//  ToastWindow
//
//  Created by Michael Ellis on 6/9/25.
//

import UIKit
import SwiftUI

class UIToastView: UIView {
    
    private let messageLabel = UILabel()
    
    init(message: String,
         duration: TimeInterval = 2.0,
         parentWindow: UIWindow) {
        
        super.init(frame: CGRect(x: parentWindow.frame.width / 2 - 50,
                                 y: parentWindow.frame.height - 150,
                                 width: 100,
                                 height: 100))
        
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        
        backgroundColor = UIColor.red.withAlphaComponent(0.8)
        layer.cornerRadius = 8
        
        addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.widthAnchor.constraint(equalToConstant: 100),
            messageLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Setup user interactions
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true

        // Initial position before animation
        alpha = 0
        frame.origin.y += 50
        
        // Begin animation
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
            self.frame.origin.y -= 50
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: duration, animations: {
                
                self.alpha = 0
                self.frame.origin.y += 50 
            }) { _ in
                self.removeFromSuperview()
            }
        }
    }
    
    @objc func dismiss() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            self.frame.origin.y += 50 // Moves down
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    /// Ignore this
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


