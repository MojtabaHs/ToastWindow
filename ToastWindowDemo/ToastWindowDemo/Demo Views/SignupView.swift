//
//  SignupView.swift
//  ToastDemo
//
//  Created by Michael Ellis on 6/10/25.
//

import SwiftUI

struct SignupView: View {
    
    @Environment(\.toastManager) private var toastManager
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isSubmitting = false

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                Text("🚀 Sign Up")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    TextField("Full Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .padding(.horizontal)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                
                Button(action: submit) {
                    if isSubmitting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.6))
                            .cornerRadius(8)
                    } else {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                .disabled(isSubmitting)
            }
            .padding()
            .background(Color(.darkGray).opacity(0.6))
            .cornerRadius(12)
            .shadow(radius: 5)
            Spacer()
        }
        .background(Color(.systemGray4))
    }
    

    private func submit() {
        isSubmitting = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isSubmitting = false
            toastManager.showToast(duration: 3.0) {
                SuccessToast()
            }
        }
    }
}

struct SuccessToast: View {
    
    @State private var isVisible = false
    
    var body: some View {
        Text("Account Created Successfully")
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)
            .font(.title.weight(.semibold))
            .frame(width: 250, height: 150) // Make it a big square
            .background(Color(.systemGreen))
            .cornerRadius(25) // Round the corners more
            .shadow(radius: 5)
            .opacity(isVisible ? 1 : 0)
            .scaleEffect(isVisible ? 1 : 0.2)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isVisible = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isVisible = false
                    }
                }
            }
    }
}
