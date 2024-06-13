//
//  NoteDetailsView.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 12/06/2024.
//

import SwiftUI

enum NoteDetailsPresentType {
    case create
    case readOnly(Note)
    case update(Note)
}

struct NoteDetailsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presenationMode
    
    @State var noteTitle: String = ""
    @State var noteContent: String = ""
    
    @State var presentType: NoteDetailsPresentType
    
    var body: some View {
        Group {
            switch self.presentType {
            case .create,
                    .update:
                newOrUpdateNoteView()
            case .readOnly(let note):
                readOnlyNoteView(note: note)
            }
        }
        .onAppear {
            loadNote()
        }
    }
    
    private func saveNote() {
        var currentNote: Note?
        
        switch presentType {
        case .create:
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
        
        currentNote?.title = noteTitle
        currentNote?.content = noteContent
        
        do {
            try self.viewContext.save()
        } catch {
            // TODO - handle errors
            print("Failed to save CoreData: ", error)
        }
    }
    
    private func loadNote() {
        switch presentType {
        case .readOnly(let note),
             .update(let note):
            self.noteTitle = note.title ?? ""
            self.noteContent = note.content ?? ""
        case .create:
            break
        }
    }
}

extension NoteDetailsView {
    
    @ViewBuilder
    func newOrUpdateNoteView() -> some View {
        Form {
            
            Section("Title") {
                TextField("Title: ", text: $noteTitle)
                    .textFieldStyle(.roundedBorder)
            }
            
            Section("Content") {
                TextField("Content", text: $noteContent)
                    .textFieldStyle(.roundedBorder)
            }
            
            Section {
                
                // Add a cancel button
                
                Button(action: {
                    saveNote()
                    presenationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                })
                .frame(maxWidth: .infinity)
            }
            
        }
    }
    
    @ViewBuilder 
    func readOnlyNoteView(note: Note) -> some View {
        Form {
            Section("Title") {
                Text(note.title ?? "")
                    .lineLimit(nil)
            }
            Section("Content") {
                Text(note.content ?? "")
                    .lineLimit(nil)
            }
            Button("Edit") {
                noteTitle = note.title ?? ""
                noteContent = note.content ?? ""
                self.presentType = .update(note)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    NoteDetailsView(presentType: .readOnly(Note.mockWith(title: "ABC", content: "This is a mock info for the content of a note")))
}
