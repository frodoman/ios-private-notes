//
//  LoginView.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 14/06/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var rootCoordinator: RootCoordinator
    
    @State var loginPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $loginPath) {
            LoginCoordinator(navigationPath: $loginPath,
                             viewContext: rootCoordinator.viewContext)
            .view()
        }
        .environmentObject(rootCoordinator)
    }
    
}

#Preview {
    LoginView()
}
