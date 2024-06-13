//
//  NoteListViewModel.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import CoreData

protocol NoteListViewModeling: ObservableObject {
    var status: NoteFetchingStatus { get }
    var viewContext: NSManagedObjectContext {get}
    
    init(viewContext: NSManagedObjectContext)
    
    func fetchNotes()
    func deleteNote(offsets: IndexSet)
}

enum NoteFetchingStatus {
    case notStarted
    case fetching
    case ready([Note])
    case error(Error)
}

final class NoteListViewModel: NoteListViewModeling {
    
    @Published
    var status: NoteFetchingStatus = .notStarted
    
    var viewContext:  NSManagedObjectContext
    
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
    
    func deleteNote(offsets: IndexSet) {
        guard case .ready(let notes) = status else {
            return
        }
        
        offsets.map { notes[$0] }.forEach(viewContext.delete)

        do {
            try viewContext.save()
        } catch {
            self.status = .error(error)
        }
    }
}
