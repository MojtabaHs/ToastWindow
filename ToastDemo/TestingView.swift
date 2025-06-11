//
//  TestingView.swift
//  ToastDemo
//
//  Created by Michael Ellis on 6/9/25.
//

import SwiftUI
import ToastWindow

struct DemoHUDView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(.circular)
                .frame(width: 180, height: 180)
                .background(Color(.systemGray4))
                .foregroundColor(.white)
                .cornerRadius(8)
            Spacer()
        }
        .transition(.opacity)
    }
}

struct TestingView: View {
    
    @State var showSheet = false
    @State var textTest = ""
    @FocusState var textFieldFocused: Bool
    @Environment(\.toastManager) var toastManager
    @Environment(\.dismissToast) var dismissToast
    @Environment(\.dismissAllToasts) var dismissAllToasts
    
    var dismissAllToastsButton: some View {
        Button("Dismiss All Toasts") {
            dismissAllToasts()
        }
        .buttonStyle(.bordered)
    }
    
    var showSwiftUIToastButton: some View {
        Button(action: {
            let toastView = MyToastView(message: "Hello World!")
            toastManager.showToast(content: toastView,
                                   duration: 2.6)
        }, label: {
            Text("Show SwiftUI Toast")
        })
        .buttonStyle(.bordered)
    }
    
    var showCenterSpinner: some View {
        Button(action: {
            let hudId = UUID()
            let toastView = DemoHUDView()
                .onTapGesture {
                    dismissToast(hudId)
                }
            let toastId = toastManager.showToast(content: toastView,
                                   id: hudId)
        }, label: {
            Text("Show Spinner Toast")
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
    
    var testTextField: some View {
        VStack {
            Button(action: {
                textFieldFocused.toggle()
            }, label: {
                Text("Toggle TextField Focus")
            })
            .buttonStyle(.bordered)
            TextField("Demo Textfield", text: $textTest)
                .textFieldStyle(.roundedBorder)
                .focused($textFieldFocused)
                .onChange(of: textFieldFocused, perform: { _ in
                    let toastView = MyToastView(message: "TextField Focused", bgColor: .red)
                    toastManager.showToast(content: toastView,
                                           duration: 2.6)
                })
        }
    }
    
    var content: some View {
        VStack(spacing: 48) {
            dismissAllToastsButton
            showCenterSpinner
            testTextField
            toggleSheetButton
            showSwiftUIToastButton
        }
    }
    
    var body: some View {
        content
            .padding()
            .sheet(isPresented: $showSheet, content: {
                content
            })
    }
}
