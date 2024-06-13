//
//  MockNoteListViewModel.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import Foundation
import CoreData

final class MockNoteListViewModel: NoteListViewModeling {
    
    var targetStatus: NoteFetchingStatus?
    var status: NoteFetchingStatus = .notStarted
    var viewContext: NSManagedObjectContext
    
    convenience init(targetStatus: NoteFetchingStatus,
                     viewContext: NSManagedObjectContext) {
        self.init(viewContext: viewContext)
        self.status = targetStatus
    }
    
    required init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        
        if let targetStatus {
            self.status = targetStatus
        } else {
            self.status = .ready(Note.mockNotes())
        }
    }
    
    func fetchNotes() {
        if let targetStatus {
            self.status = targetStatus
        }
    }

    func deleteNote(offsets: IndexSet) {
        
    }
}
