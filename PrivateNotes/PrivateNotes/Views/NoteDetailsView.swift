//
//  NoteDetailsView.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 12/06/2024.
//

import SwiftUI

struct NoteDetailsView<ViewModelType>: View where ViewModelType: NoteDetailsViewModeling {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject
    var viewModel: ViewModelType
    
    var flowHandler: NoteFlowHandler?
    
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
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action : {
                self.presentationMode.wrappedValue.dismiss()
                self.flowHandler?(.dismissDetails)
        }) {
            Image(systemName: "arrow.left")
        })
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
                    self.flowHandler?(.dismissDetails)
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
                    self.flowHandler?(.didSave)
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
        }
        Spacer()
        Button(action: {
            viewModel.prepareForUpdate()
        }) {
            CTALabel(title: "Edit")
        }
        Spacer()
    }
}

#Preview {
    NoteDetailsView(viewModel: MockNoteDetailsViewModel(presentType: .readOnly(Note.mock()),
                                                        viewContext: PersistenceController.preview.container.viewContext))
    
                        
                    
}
