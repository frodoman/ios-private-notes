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

extension LoginError: Equatable {
    static func == (lhs: LoginError, rhs: LoginError) -> Bool {
        var theSame = false
        switch (lhs, rhs) {
        case (.biomatricNotAvailable, .biomatricNotAvailable),
            (.authenticatedFailed, .authenticatedFailed):
            theSame = true
        default:
            break
        }
        return theSame
    }
    
    
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
        var theSame = false
        switch (lhs, rhs) {
        case (.loginSucceeded, .loginSucceeded),
             (.notStarted, .notStarted),
             (.loginFailed, .loginFailed):
            theSame = true

        default:
            theSame = lhs.id == rhs.id
        }
        return theSame
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
