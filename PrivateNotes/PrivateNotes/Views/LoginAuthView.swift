//
//  LoginView.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import SwiftUI
import LocalAuthentication

struct LoginAuthView<ViewModelType>: View where ViewModelType: LoginViewModeling {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var rootCoordinator: RootCoordinator
    @ObservedObject var viewModel: ViewModelType
    
    var flowHandler: LoginFlowHandler?
    
    var body: some View {
        VStack {
            loginWithButtonView()
        }
        .onChange(of: viewModel.loginResult) { newValue in
            if case .loginSucceeded = newValue {
                rootCoordinator.isAuthenticated = true
                presentationMode.wrappedValue.dismiss()
            }
            else if case .loginFailed(_) = newValue {
                flowHandler?(newValue)
            }
        }
        
    }
    
    private func requestAuthentication() {
        viewModel.login()
    }
    
    @ViewBuilder
    func loginWithButtonView() -> some View {
        Spacer()
        Text("Private notes")
            .font(.title)
            .padding()
        Text("Please login")
            .font(.title2)
        Spacer()
        Button(action: {
            self.requestAuthentication()
        }, label: {
            CTALabel(title: "Login")
        })
        Spacer()
    }
}

#Preview {
    LoginAuthView(viewModel: MockLoginViewModel(loginResult: .notStarted))
}
