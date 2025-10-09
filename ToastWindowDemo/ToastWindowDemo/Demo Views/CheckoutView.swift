//
//  CheckoutView.swift
//  ToastDemo
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI

struct CheckoutView: View {
    @State private var isProcessing = false
    @State private var purchaseSuccess = false
    @State private var showAppleOffer = false
    
    @Environment(\.toastManager) private var toastManager
    
    var body: some View {
        VStack(spacing: 20) {
            Text("🥖 Bakery Checkout 🍞")
                .font(.largeTitle)
                .bold()
            
            VStack(spacing: 12) {
                Text("🍞 Bread - $3.99")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("🍇 Jelly - $2.49")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("🧈 Butter - $3.29")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.systemGray6))
                    .shadow(radius: 6)
            )
            
            
            VStack(spacing: 12) {
                Text("Total: $9.77")
                    .font(.title2)
                    .bold()
                
                Button(action: {
                    showAppleOffer = true
                }) {
                    Text("🍎 See Special Offers")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemOrange))
                                .shadow(radius: 6)
                        )
                        .foregroundColor(.black)
                }
                
                Button(action: processPurchase) {
                    Text(isProcessing ? "🥯 Toasting... 🔥" : "🧈 Complete Order")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemYellow))
                                .shadow(radius: 6)
                        )
                        .foregroundColor(.black)
                }
                .disabled(isProcessing)
            }
            .padding()
            Text("🧑‍🍳 Freshly baked with love!")
                .font(.caption)
                .foregroundColor(.black)
            Spacer()
        }
        .padding().padding()
        .sheet(isPresented: $showAppleOffer) {
            appleOfferSheet
        }
    }

    private var appleOfferSheet: some View {
        VStack(spacing: 20) {
            Text("🍏 Would you like to add apples?")
                .font(.title)
                .bold()

            Text("Just $1.99 for a fresh addition!")
                .font(.title2)

            HStack {
                Button("✅ Yes, add and buy") {
                    showAppleOffer = false
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.green.opacity(0.8))
                )
                .foregroundColor(.white)

                Button("❌ No, buy as-is") {
                    toastManager.showToast(duration: 2.0) {
                        DraggableToastView(message: "No Apples For You!")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.red.opacity(0.8))
                )
                .foregroundColor(.white)
            }
            .padding()
        }
        .padding()
    }

    
    private func processPurchase() {
        isProcessing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isProcessing = false
            
            let message = purchaseSuccess ? "✅ Order placed successfully!" : "❌ Payment failed. Please try again."

            toastManager.showToast(duration: 2.6) {
                MyToastView(message: message, bgColor: Color.gray.opacity(0.8), position: .bottom)
            }

            purchaseSuccess.toggle()
        }
    }
}
