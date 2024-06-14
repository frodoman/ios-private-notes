//
//  RootView.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var rootCoordinator: RootCoordinator
    
    @State var showLogin: Bool = true
    
    var body: some View {
        NoteCoordinator(navigationPath: $rootCoordinator.navigationPath,
                        viewContext: rootCoordinator.viewContext)
                        .view()
                        //NOTE: - for simmulator testing, comment out the following 
                        .fullScreenCover(isPresented: $showLogin) {
                            LoginView()
                        }
    }
}

#Preview {
    ContentView()
}
