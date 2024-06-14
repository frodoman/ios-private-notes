//
//  NoteDetailsViewModel.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import CoreData

protocol NoteDetailsViewModeling: ObservableObject {
    var presentType: NoteDetailsPresentType { get }
    var noteTitle: String { get set }
    var noteContent: String { get set }
    
    init(presentType: NoteDetailsPresentType,
         viewContext: NSManagedObjectContext)
    
    func save()
    func prepareForUpdate()
    func cancelUpdate()
}

enum NoteDetailsPresentType {
    case create
    case readOnly(Note)
    case update(Note)
    case error(Error)
    case didSave(Note)
}

extension NoteDetailsPresentType: Hashable {
    
    static func == (lhs: NoteDetailsPresentType, rhs: NoteDetailsPresentType) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension NoteDetailsPresentType: Identifiable {
    var id: UUID {
        UUID()
    }
}

final class NoteDetailsViewModel: NoteDetailsViewModeling {

    @Published
    var presentType: NoteDetailsPresentType
    
    @Published
    var noteTitle: String = ""
    
    @Published
    var noteContent: String = ""
    
    private let viewContext: NSManagedObjectContext
    
    required init(presentType: NoteDetailsPresentType,
                  viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        self.presentType = presentType
    }
    
    func save() {
        var currentNote: Note?
        
        switch presentType {
        case .create,
             .error,
             .didSave:
            break
        case .readOnly(let note),
             .update(let note):
            currentNote = note
        }
        
        if currentNote == nil {
            currentNote = Note(context: viewContext)
            currentNote?.id = UUID()
            currentNote?.timestamp = Date()
        }
        
        guard let currentNote else { return }
        
        currentNote.title = noteTitle
        currentNote.content = noteContent
        
        do {
            try self.viewContext.save()
            presentType = .didSave(currentNote)
        } catch {
            presentType = .error(error)
        }
    }
    
    func prepareForUpdate() {
        guard case .readOnly(let note) = presentType else {
            return
        }

        self.presentType = .update(note)
        self.noteTitle = note.title ?? ""
        self.noteContent = note.content ?? ""
    }
    
    func cancelUpdate() {
        guard case .update(let note) = presentType else {
            return
        }
        self.presentType = .readOnly(note)
    }
}
