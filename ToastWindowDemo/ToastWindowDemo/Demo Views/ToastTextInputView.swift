//
//  ToastTextInputView.swift
//  ToastWindowDemo
//
//  Created by Michael Ellis on 6/12/25.
//

import SwiftUI
import ToastWindow

struct ToastTextInputView: View {
    
    @Environment(\.toastManager) var toastManager
    @State private var userName = "Tim Cook"
    
    var body: some View {
        VStack(spacing: 16) {
            Text("User Profile")
                .font(.title2)
                .bold()
            
            HStack {
                Text("Name:")
                    .fontWeight(.semibold)
                Spacer()
                Text(userName)
            }
            
            HStack {
                Text("Company:")
                    .fontWeight(.semibold)
                Spacer()
                Text("Apples & Toast Inc.")
            }
            
            Button("Update Name") {
                let id = ToastID()
                let toastView = OverlayTextInputToastView(toastID: id, userName: $userName)
                _ = toastManager.showToast(content: toastView,
                                       id: id)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            Button("Close") {
                let toastID = UUID()
                _ = toastManager.showToast(content: self, id: toastID)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
        .frame(maxWidth: 350)
        .background(.thinMaterial)
        .cornerRadius(14)
        .shadow(radius: 10)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: userName)
    }
}



struct OverlayTextInputToastView: View {
    
    @Environment(\.dismissToast) var dismissToast
    var toastID: ToastID
    @Binding var userName: String

    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("Name Change")
                    .font(.title)
                
                TextField("Enter text...", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Done") {
                    dismissToast(toastID)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 8)
            Spacer()
        }
        .padding()
        .background {
            Color.black.opacity(0.8) // Dimmed background effect
                .edgesIgnoringSafeArea(.all)
                .onTapGesture { dismissToast(toastID) } // Dismiss on tap
        }
    }
}
