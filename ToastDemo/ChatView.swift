//
//  ChatView.swift
//  ToastDemo
//
//  Created by Michael Ellis on 6/10/25.
//

import SwiftUI

struct ChatView: View {
    
    @Environment(\.toastManager) private var toastManager
    
    @State private var messages: [Message] = [
        Message(text: "What are you having for breakfast?", isSender: false),
        Message(text: "Thinking of making some toast.", isSender: true),
        Message(text: "Nice! Butter or jam?", isSender: false)
    ]
    @State private var newMessage = ""

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(messages, id: \.id) { message in
                        HStack {
                            if message.isSender {
                                Spacer()
                                Text(message.text)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                            } else {
                                Text(message.text)
                                    .padding()
                                    .background(Color(.systemGray3))
                                    .cornerRadius(16)
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }

            Spacer()

            HStack {
                TextField("Type here...", text: $newMessage)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
                    .frame(maxWidth: .infinity)

                Button(action: sendMessage) {
                    Text("Send")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }
            }
            .padding()
            .background(Color.white)
        }
        .background(Color(.systemGray5))
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    var newMessageNotification: some View {
        MyToastView(message: "💬 New Message Received",
                    position: .top,
                    duration: 2.6)
    }
    
    private func sendMessage() {
        guard !newMessage.isEmpty else { return }
        messages.append(Message(text: newMessage, isSender: true))
        // Wait 1.5 seconds, then add a response from the other person
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            toastManager.showToast(content: newMessageNotification,
                                   duration: 2.6,
                                   position: .top)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                messages.append(Message(text: "Sounds delicious!", isSender: false))
            }
        }
        newMessage = ""
    }
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isSender: Bool
}

// Helper function for keyboard dismissal
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
