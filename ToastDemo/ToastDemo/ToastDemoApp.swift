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
    @State var toastPosition: ToastPosition = .bottom
    
    var toastPositionPicker: some View {
        Picker("Toast Position", selection: $toastPosition) {
            Text("Top").tag(ToastPosition.top)
            Text("Middle").tag(ToastPosition.middle)
            Text("Bottom").tag(ToastPosition.bottom)
        }
        .pickerStyle(.segmented)
    }
    
    var showSwiftUIToastButton: some View {
        Button(action: {
            let toastView = MyToastView(message: "Hello World!",
                                        position: toastPosition)
            toastManager.showToast(content: toastView,
                                   duration: 2.6,
                                   position: toastPosition)
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
            toastPositionPicker
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
