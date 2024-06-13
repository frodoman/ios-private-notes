//
//  MockNoteDetailsViewModel.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import CoreData

final class MockNoteDetailsViewModel: NoteDetailsViewModeling {
    
    var noteTitle: String
    
    var noteContent: String
    
    var presentType: NoteDetailsPresentType
    
    private let viewContext: NSManagedObjectContext
    
    required init(presentType: NoteDetailsPresentType,
                  viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        self.presentType = presentType
        self.noteTitle = ""
        self.noteContent = ""
    }
    
    func save() {
        
    }
    
    func prepareForUpdate() {
        
    }
    
    func cancelUpdate() {
        
    }
}
