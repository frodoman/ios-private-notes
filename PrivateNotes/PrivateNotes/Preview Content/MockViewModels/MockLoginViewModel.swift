//
//  MockLoginViewModel.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 14/06/2024.
//

import Foundation
import LocalAuthentication

final class MockLoginViewModel: LoginViewModeling {
    
    private let context: LAContexting
    var loginResult: LoginResult = .notStarted
    
    init(context: LAContexting = MockLAContext()) {
        self.context = context
    }
    
    func login() {
        loginResult = .loginSucceeded
    }
    
}

struct MockLAContext: LAContexting {
    
    var canEvaluate: Bool = false
    var loginSucceed: Bool = false
    var loginError: Error? = MockError.FailedLogin
    
    func canEvaluatePolicy(_ policy: LAPolicy, error: NSErrorPointer) -> Bool {
        canEvaluate
    }
    
    func evaluatePolicy(_ policy: LAPolicy,
                        localizedReason: String,
                        reply: @escaping (Bool, Error?) -> Void) {
        reply(loginSucceed, loginError)
    }
}
