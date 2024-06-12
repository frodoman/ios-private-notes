//
//  PrivateNotesApp.swift
//  PrivateNotes
//
//  Created by X_coder on 12/06/2024.
//

import SwiftUI

@main
struct PrivateNotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
