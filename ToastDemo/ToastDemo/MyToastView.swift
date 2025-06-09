//
//  MyToastView.swift
//  ToastDemo
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI
import ToastWindow

struct MyToastView: View {
    let toaster = ToastManager()
    @State var message: String
    let position: ToastPosition
    /// Total duration that the toast will be visible on screen
    let duration: TimeInterval = 2.0
    /// Duration of the movement in and out
    let animationDuration: TimeInterval = 0.3
    /// Opacity control
    @State private var isVisible = false
    /// Start position
    let initialOffsetY: CGFloat
    @State private var offsetY: CGFloat
    
    init(message: String,
         position: ToastPosition = .bottom) {
        self.message = message
        self.position = position
        switch position {
        case .bottom:
            self.initialOffsetY = 50
            self.offsetY = 50
        case .middle:
            self.initialOffsetY = 0
            self.offsetY = 0
        case .top:
            self.initialOffsetY = -50
            self.offsetY = -50
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .padding()
                .frame(width: 150, height: 50)
                .background(Color.red.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(8)
                .opacity(isVisible ? 1 : 0)
                .offset(y: offsetY)
                .onTapGesture {
                    message = "Tapped!!!"
                }
                .gesture(DragGesture().onEnded({ _ in
                    message = "Swiped!!!"
                }))
                .contentShape(Rectangle())
                .onAppear {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        offsetY = 0
                        isVisible = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + (duration + animationDuration)) {
                        withAnimation(.easeInOut(duration: animationDuration)) {
                            offsetY = initialOffsetY
                            isVisible = false
                        }
                    }
                }
        }
    }
}
