//
//  CheckoutView.swift
//  ToastDemo
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI

struct CheckoutView: View {
    @State private var isProcessing = false
    @State private var purchaseSuccess: Bool = false
    
    @Environment(\.toastManager) private var toastManager
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🛒 Checkout")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            VStack(spacing: 12) {
                Text("Total: $49.99")
                    .font(.title2)
                
                Button(action: processPurchase) {
                    Text(isProcessing ? "Processing..." : "Complete Purchase")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(isProcessing)
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
    
    private func processPurchase() {
        isProcessing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isProcessing = false
            
            let message = purchaseSuccess ? "✅ Order placed successfully!" : "❌ Payment failed. Please try again."
            let toastView = MyToastView(message: message, bgColor: Color.gray.opacity(0.8))
            toastManager.showToast(content: toastView, duration: 2.6)
            
            purchaseSuccess.toggle()
        }
    }
}
