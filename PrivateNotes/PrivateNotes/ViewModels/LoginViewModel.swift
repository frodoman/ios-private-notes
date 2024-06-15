//
//  LoginViewModel.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 14/06/2024.
//

import Foundation
import LocalAuthentication

protocol LoginViewModeling: ObservableObject {
    var loginResult: LoginResult { get }
    
    init(context: LAContexting)
    
    func login()
}

final class LoginViewModel: LoginViewModeling {
    
    @Published
    var loginResult: LoginResult = .notStarted
    
    private let context: LAContexting
    
    init(context: LAContexting = LAContext()) {
        self.context = context
    }
    
    func login() {
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access the app"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                if success{
                    self.set(result: .loginSucceeded)
                    
                } else if let error {
                    self.set(result: .loginFailed(error))
                }
            }
        } else {
            // Device does not support Face ID or Touch ID
            self.set(result: .loginFailed(LoginError.biomatricNotAvailable))
        }
    }
    
    private func set(result: LoginResult) {
        DispatchQueue.main.async {
            self.loginResult = result
        }
    }
}
