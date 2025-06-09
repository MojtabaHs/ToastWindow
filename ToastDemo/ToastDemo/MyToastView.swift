//
//  MyToastView.swift
//  ToastDemo
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI

struct MyToastView: View {
    @State var message: String
    /// Total duration that the toast will be visible on screen
    let duration: TimeInterval = 2.0
    /// Duration of the movement in and out
    let animationDuration: TimeInterval = 0.3
    /// Opacity control
    @State private var isVisible = false
    /// Start position
    @State private var offsetY: CGFloat = 50
    
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .padding()
                .frame(width: 400)
                .background(Color.red.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(8)
                .opacity(isVisible ? 1 : 0)
                .offset(y: offsetY)
                .onTapGesture {
                    message = "tappped!!!"
                }
                .contentShape(Rectangle())
                .onAppear {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        offsetY = -50
                        isVisible = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + (duration + animationDuration)) {
                        withAnimation(.easeInOut(duration: animationDuration)) {
                            offsetY = 50 // Moves back down
                            isVisible = false
                        }
                    }
                }
        }
    }
}
