//
//  RootView.swift
//  PrivateNotes
//
//  Created by X_coder on 13/06/2024.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var rootCoordinator: RootCoordinator
    
    var body: some View {
        NoteCoordinator(navigationPath: $rootCoordinator.navigationPath,
                        viewContext: rootCoordinator.viewContext)
                        .view()
    }
}

#Preview {
    RootView()
}
