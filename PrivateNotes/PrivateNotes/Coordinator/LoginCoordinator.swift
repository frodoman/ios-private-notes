//
//  LoginCoordinator.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 14/06/2024.
//

import SwiftUI
import CoreData

final class LoginCoordinator: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    
    @Binding var navigationPath: NavigationPath
    
    let viewContext: NSManagedObjectContext
    
    init(navigationPath: Binding<NavigationPath>,
         viewContext: NSManagedObjectContext) {
        self._navigationPath = navigationPath
        self.viewContext = viewContext
    }
    
    @ViewBuilder
    func view() -> some View {
        LoginAuthView(viewModel: LoginViewModel()) { result in
            switch result {
            case .notStarted:
                break
            case .loginFailed:
                self.navigationPath.append(result)
            case .loginSucceeded:
                self.isAuthenticated = true
                self.navigationPath.append(result)
            }
        }
        .navigationDestination(for: LoginResult.self) { result in
            if case .loginFailed(let error) = result {
                ErrorView(error: error)
            }
        }
    }
    
    @ViewBuilder
    func noteDetailsView(presentType: NoteDetailsPresentType) -> some View {
        NoteDetailsView(viewModel: NoteDetailsViewModel(presentType: presentType,
                                                        viewContext: viewContext)) { type in
            switch type {
            case .dismissDetails,
                    .didSave:
                self.navigationPath.removeLast()
            default:
                break
            }
        }
    }
}

