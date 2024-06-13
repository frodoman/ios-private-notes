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
            NoteListView()
                //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
