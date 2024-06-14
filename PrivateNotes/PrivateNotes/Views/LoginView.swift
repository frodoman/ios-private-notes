//
//  LoginView.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 14/06/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var rootCoordinator: RootCoordinator
    
    var body: some View {
        LoginCoordinator(navigationPath: $rootCoordinator.navigationPath,
                         viewContext: rootCoordinator.viewContext)
        .view()
    }
    
}

#Preview {
    LoginView()
}
