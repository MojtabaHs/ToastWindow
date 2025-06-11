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
        VStack(spacing: 20) {
            Text("🚀 Sign Up")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.blue)

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
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
    
    var successToast: some View {
        Text("🍞 Submission Accepted 🥂")
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 5)
    }

    private func submit() {
        isSubmitting = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isSubmitting = false
            toastManager.showToast(content: successToast,
                                   duration: 2.0,
                                   position: .middle)
        }
    }
}
