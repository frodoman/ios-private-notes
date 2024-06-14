//
//  MockLoginViewModel.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 14/06/2024.
//

import Foundation

final class MockLoginViewModel: LoginViewModeling {
    var loginResult: LoginResult
    
    init(loginResult: LoginResult) {
        self.loginResult = loginResult
    }
    
    func login() {
        loginResult = .loginSucceeded
    }
    
}
