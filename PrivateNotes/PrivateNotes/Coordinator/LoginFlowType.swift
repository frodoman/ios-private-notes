//
//  LoginFlowType.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 14/06/2024.
//

import Foundation
import Combine

typealias LoginFlowHandler = ((LoginResult)->Void)

enum LoginError: Error {
    case biomatricNotAvailable
    case authenticatedFailed(Error)
}

enum LoginResult {
    case notStarted
    case loginSucceeded
    case loginFailed(Error)
}

extension LoginResult: Identifiable {
    var id: UUID {
        UUID()
    }
}

extension LoginResult: Hashable {
    static func == (lhs: LoginResult, rhs: LoginResult) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
