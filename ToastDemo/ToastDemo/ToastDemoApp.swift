//
//  ToastDemoApp.swift
//  ToastDemo
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI
import ToastWindow


@main
struct ToastDemoApp: App {
    
    @State var showSheet = false
    @Environment(\.toastManager) var toastManager
    
    var showSwiftUIToastButton: some View {
        Button(action: {
            toastManager.showToast(content: MyToastView(message: "Hello World!"))
        }, label: {
            Text("Show SwiftUI Toast")
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
            showSwiftUIToastButton
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
