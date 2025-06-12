//
//  ToastWindowDemoApp.swift
//  ToastWindowDemoApp
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI
import ToastWindow

@main
struct ToastWindowDemoApp: App {
    
    enum NavLocation {
        case testing
        case checkout
        case signup
        case chat
        case drag
        case textfield
    }
    
    @State var navPath = NavigationPath()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navPath) {
                VStack(spacing: 24) {
                    Button("Testing View") {
                        navPath.append(NavLocation.testing)
                    }
                    .buttonStyle(.bordered)
                    Button("Checkout Demo") {
                        navPath.append(NavLocation.checkout)
                    }
                    .buttonStyle(.bordered)
                    Button("Signup Demo") {
                        navPath.append(NavLocation.signup)
                    }
                    .buttonStyle(.bordered)
                    Button("Chat Demo") {
                        navPath.append(NavLocation.chat)
                    }
                    .buttonStyle(.bordered)
                    Button("Drag Demo") {
                        navPath.append(NavLocation.drag)
                    }
                    .buttonStyle(.bordered)
                    Button("Textfield Demo") {
                        navPath.append(NavLocation.textfield)
                    }
                    .buttonStyle(.bordered)
                }
                .navigationDestination(for: NavLocation.self, destination: { navLocation in
                    switch navLocation {
                    case .testing:
                        TestingView()
                    case .checkout:
                        CheckoutView()
                    case .signup:
                        SignupView()
                    case .chat:
                        ChatView()
                    case .drag:
                        DragView()
                    case .textfield:
                        ToastTextInputView()
                    }
                })
            }
        }
    }
}
