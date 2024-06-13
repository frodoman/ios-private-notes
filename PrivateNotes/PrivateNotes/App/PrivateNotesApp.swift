//
//  PrivateNotesApp.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 12/06/2024.
//

import SwiftUI
import CoreData

@main
struct PrivateNotesApp: App {
    
    @StateObject var coordinator = RootCoordinator(navigationPath: NavigationPath(),
                                                   context: PersistenceController.viewContext)
    

    var body: some Scene {
        WindowGroup {
  
            NavigationStack(path: $coordinator.navigationPath) {
                coordinator.view()
            }
            .environmentObject(coordinator)
        }
    }
}
