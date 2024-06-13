//
//  NoteDetailsView.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 12/06/2024.
//

import SwiftUI

struct NoteDetailsView<ViewModelType>: View where ViewModelType: NoteDetailsViewModeling {

    @Environment(\.presentationMode) var presenationMode
    
    @ObservedObject
    var viewModel: ViewModelType
    
    var body: some View {
        Group {
            switch viewModel.presentType {
            case .create,
                 .update:
                newOrUpdateNoteView()
            case .readOnly(let note):
                readOnlyNoteView(note: note)
            case .error(let error):
                ErrorView(error: error)
            }
        }
        .onAppear {
            loadNote()
        }
    }
    
    private func saveNote() {
        viewModel.save()
    }
    
    private func loadNote() {

    }
}

extension NoteDetailsView {
    
    @ViewBuilder
    func newOrUpdateNoteView() -> some View {
        Form {
            
            Section("Title") {
                TextField("Title: ", text: $viewModel.noteTitle)
                    .textFieldStyle(.roundedBorder)
            }
            
            Section("Content") {
                TextField("Content", text: $viewModel.noteContent)
                    .textFieldStyle(.roundedBorder)
            }
            
            // Cancel button
            Section {
                Button(action: {
                    viewModel.cancelUpdate()
                }, label: {
                    Text("Cancel")
                })
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity)
            }
            
            // Save button
            Section {
                
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
                viewModel.prepareForUpdate()
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    NoteDetailsView(viewModel: MockNoteDetailsViewModel(presentType: .readOnly(Note.mock()),
                                                        viewContext: PersistenceController.preview.container.viewContext))
    
                        
                    
}
