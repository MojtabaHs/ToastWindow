//
//  ToastDemoApp.swift
//  ToastDemo
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI

@main
struct ToastDemoApp: App {
    
    @State var showSheet = false
//    @ObservedObject var toastManager = ToastManager.shared
    
    var showToastButton: some View {
        Button(action: {
//            toastManager.showToast(message: "Animated Toast Message")
        }, label: {
            Text("Show Animated Toast")
        })
        .buttonStyle(.bordered)
    }
    
    var toggleSheetButton: some View {
        Button(action: {
            showSheet.toggle()
        }, label: {
            Text("Toggle Sheet Display")
        })
        .buttonStyle(.bordered)
    }
    
    var content: some View {
        VStack(spacing: 48) {
            
            toggleSheetButton
            
            showToastButton
        }
    }
    
    var body: some Scene {
        WindowGroup {
            content
                .padding()
                .sheet(isPresented: $showSheet, content: {
                    content
                })
        }
    }
}
