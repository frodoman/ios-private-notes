//
//  Note+Preview.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 12/06/2024.
//

import Foundation

extension Note {
    
    static func mockWith(title: String, content: String?) -> Note {
        let viewContext = PersistenceController.preview.container.viewContext
        let note = Note(context: viewContext)
        note.title = title
        note.content = content
        note.id = UUID()
        note.timestamp = Date()
        
        return note
    }
    
    static func mockNotes() -> [Note] {
        let mockNotes: [Note] = [
            Note.mockWith(title: "Title 1", content: "Content 1"),
            Note.mockWith(title: "Title 2", content: "Content 2"),
            Note.mockWith(title: "Title 3", content: "Content 3"),
            Note.mockWith(title: "Title 4", content: "Content 5"),
        ]
        return mockNotes
    }
}
