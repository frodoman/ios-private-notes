//
//  LoginView.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import SwiftUI
import LocalAuthentication

struct LoginAuthView<ViewModelType>: View where ViewModelType: LoginViewModeling {

    @Environment(\.isPresented) var isPresented
    
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
            }
            else if case .loginFailed(_) = newValue {
                flowHandler?(newValue)
            }
        }
        
    }
    
    private func requestAuthentication() {
// TODO: This is just a temp solution to login when running on simulator
// Should remove this in production codes
#if targetEnvironment(simulator)
        rootCoordinator.isAuthenticated = true
#else
        viewModel.login()
#endif
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
    LoginAuthView(viewModel: MockLoginViewModel(context: MockLAContext(canEvaluate: true,
                                                                      loginSucceed: true,
                                                                      loginError: nil)))
}
