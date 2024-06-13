//
//  NoteListViewModel.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import Combine
import CoreData

protocol NoteListViewModeling: ObservableObject {
    var status: NoteFetchingStatus {get}
    
    func fetchNotes()
    
    init(viewContext: NSManagedObjectContext)
}

enum NoteFetchingStatus {
    case notStarted
    case fetching
    case ready([Note])
    case error(Error)
}

class NoteListViewModel: NoteListViewModeling {
    
    @Published
    var status: NoteFetchingStatus = .notStarted
    
    private var viewContext:  NSManagedObjectContext
    
    required init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func fetchNotes() {
        let request = Note.fetchRequest()
        let sort = NSSortDescriptor(keyPath: \Note.timestamp, ascending: true)
        request.sortDescriptors = [sort]
        do {
            let notes = try viewContext.fetch(request)
            self.status = .ready(notes)
            
        } catch {
            self.status = .error(error)
        }
    }
}
