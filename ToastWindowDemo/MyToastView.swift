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
    /// Total duration that the toast will be visible on screen
    let duration: TimeInterval
    /// Duration of the movement in and out
    let animationDuration: TimeInterval
    /// Opacity control
    @State private var isVisible = false
    /// Start position
    let initialOffsetY: CGFloat
    @State private var offsetY: CGFloat
    
    init(message: String,
         duration: TimeInterval = 2.6,
         animationDuration: TimeInterval = 0.3,
         bgColor: Color = .gray) {
        self.message = message
        self.duration = duration
        self.animationDuration = animationDuration
        self.bgColor = bgColor
        self.initialOffsetY = 50
        self.offsetY = 50
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .padding()
                .background(bgColor)
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + (duration - animationDuration)) {
                        withAnimation(.easeInOut(duration: animationDuration)) {
                            offsetY = initialOffsetY
                            isVisible = false
                        }
                    }
                }
        }
    }
}
