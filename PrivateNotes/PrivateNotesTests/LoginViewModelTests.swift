//
//  LoginViewModelTests.swift
//  PrivateNotesTests
//
//  Created by X_coder on 15/06/2024.
//

import XCTest
import Combine
@testable import PrivateNotes

final class LoginViewModelTests: XCTestCase {

    var viewModel: LoginViewModel!
    var cancelables: [AnyCancellable] = []
    
    override func setUpWithError() throws {
        viewModel = LoginViewModel(context: MockLAContext())
    }

    func testLoginSucceeded() throws {
        // given
        let context = MockLAContext(canEvaluate: true,
                                    loginSucceed: true,
                                    loginError: nil)
        
        viewModel = LoginViewModel(context: context)
        
        let exp = expectation(description: "Login should be succeeded")
        var loginResult: LoginResult = .notStarted
        
        viewModel.$loginResult.sink { result in
            if result != .notStarted {
                loginResult = result
                exp.fulfill()
            }
        }
        .store(in: &cancelables)
        
        // when
        viewModel.login()
        wait(for: [exp], timeout: 5)
        
        // then
        XCTAssertEqual(loginResult, PrivateNotes.LoginResult.loginSucceeded)
    }
    
    func testLoginFailed() throws {
        // given
        let error = MockError.FailedLogin
        let context = MockLAContext(canEvaluate: true,
                                    loginSucceed: false,
                                    loginError: LoginError.authenticatedFailed(error))
        
        viewModel = LoginViewModel(context: context)
        
        let exp = expectation(description: "Login should be failed")
        var loginResult: LoginResult = .notStarted
        
        viewModel.$loginResult.sink { result in
            if result != .notStarted {
                loginResult = result
                exp.fulfill()
            }
        }
        .store(in: &cancelables)
        
        // when
        viewModel.login()
        wait(for: [exp], timeout: 5)
        
        // then
        XCTAssertEqual(loginResult, PrivateNotes.LoginResult.loginFailed(error))
    }
    
    func testLoginFailed_BiomatricNotAvailable() throws {
        // given
        let error = LoginError.biomatricNotAvailable
        let context = MockLAContext(canEvaluate: false,
                                    loginSucceed: false,
                                    loginError: LoginError.authenticatedFailed(error))
        
        viewModel = LoginViewModel(context: context)
        
        let exp = expectation(description: "Login should be failed")
        var loginResult: LoginResult = .notStarted
        var loginError: LoginError?
        
        viewModel.$loginResult.sink { result in
            if case .loginFailed(let returnError) = result {
                loginResult = result
                
                if let returnLoginError = returnError as? LoginError {
                    loginError = returnLoginError
                    exp.fulfill()
                }
            }
        }
        .store(in: &cancelables)
        
        // when
        viewModel.login()
        wait(for: [exp], timeout: 5)
        
        // then
        XCTAssertEqual(loginResult, PrivateNotes.LoginResult.loginFailed(error))
        XCTAssertEqual(loginError, LoginError.biomatricNotAvailable)
    }

}
