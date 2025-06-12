//
//  MyToastView.swift
//  ToastDemo
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI
import ToastWindow

struct MyToastView: View {
    @State var message: String
    let bgColor: Color
    let duration: TimeInterval
    let animationDuration: TimeInterval
    let position: ToastPosition
    
    @State private var isVisible = false
    @State private var offsetY: CGFloat
    
    init(message: String,
         duration: TimeInterval = 2.6,
         animationDuration: TimeInterval = 0.3,
         bgColor: Color = .gray,
         position: ToastPosition) { // Default to bottom
        self.message = message
        self.duration = duration
        self.animationDuration = animationDuration
        self.bgColor = bgColor
        self.position = position
        self.offsetY = (position == .top) ? -50 : 50 // Start above or below
    }
    
    var body: some View {
        VStack {
            if position == .bottom { Spacer() }
            Text(message)
                .padding()
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .background(bgColor)
                .foregroundColor(.white)
                .cornerRadius(8)
                .opacity(isVisible ? 1 : 0)
                .offset(y: offsetY)
                .onAppear {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        offsetY = 0
                        isVisible = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + (duration - animationDuration)) {
                        withAnimation(.easeInOut(duration: animationDuration)) {
                            offsetY = (position == .top) ? -50 : 50
                            isVisible = false
                        }
                    }
                }
            if position == .top { Spacer() }
        }
        .padding(.horizontal, 24)
    }
}

