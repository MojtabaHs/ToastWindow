//
//  DraggableToastView.swift
//  ToastWindowDemo
//
//  Created by Michael Ellis on 6/12/25.
//

import SwiftUI
import ToastWindow

struct DragView: View {
    
    @Environment(\.toastManager) var toastManager
    @Environment(\.dismissAllToasts) var dismissAllToasts
    
    var body: some View {
        Button("Open Draggable Toast") {            
            toastManager.showToast {
                DraggableToastView(message: "Drag this toast! 🍞🍴🧈", duration: 4.0, animationDuration: 0.5, bgColor: .blue)
            }
        }
        .buttonStyle(.bordered)
    }
}

struct DraggableToastView: View {
    @State var message: String
    let bgColor: Color
    let duration: TimeInterval
    let animationDuration: TimeInterval
    
    @State private var isVisible = false
    @State private var dragOffset: CGSize = .zero
    
    init(message: String,
         duration: TimeInterval = 2.6,
         animationDuration: TimeInterval = 0.3,
         bgColor: Color = .gray) {
        self.message = message
        self.duration = duration
        self.animationDuration = animationDuration
        self.bgColor = bgColor
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .padding()
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .background(bgColor)
                .foregroundColor(.white)
                .cornerRadius(8)
                .opacity(isVisible ? 1 : 0)
                .offset(x: dragOffset.width, y: dragOffset.height)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                dragOffset = dragOffset // Keep its new position
                            }
                        }
                )
                .onAppear {
                    withAnimation(.easeInOut(duration: animationDuration)) {
                        isVisible = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + (duration - animationDuration)) {
                        withAnimation(.easeInOut(duration: animationDuration)) {
                            isVisible = false
                        }
                    }
                }
            Spacer()
        }
        .padding(.horizontal, 24)
    }
}
