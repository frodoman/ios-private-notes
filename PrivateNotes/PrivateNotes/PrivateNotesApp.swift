//
//  PrivateNotesApp.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 12/06/2024.
//

import SwiftUI

@main
struct PrivateNotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NoteListView(viewModel: NoteListViewModel(viewContext: persistenceController.container.viewContext))
        }
    }
}
