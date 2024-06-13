//
//  ContentView.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 12/06/2024.
//

import SwiftUI
import CoreData

struct NoteListView<ViewModelType>: View where ViewModelType: NoteListViewModeling {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject
    var viewModel: ViewModelType
    
    var body: some View {
        NavigationView {
            
            Group {
                switch (viewModel.status) {
                case .notStarted,
                     .fetching:
                    ProgressView()
                case .error(let error):
                    Text("Error: \(error.localizedDescription)")
                        .foregroundStyle(.red)
                
                case .ready(let notes):
                    List {
                        ForEach(notes) { item in
                            NavigationLink {
                                NoteDetailsView(presentType: .readOnly(item))
                            } label: {
                                Text(item.title ?? "")
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                
                }
            }
            .onAppear {
                viewModel.fetchNotes()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                
                    NavigationLink {
                        NoteDetailsView(presentType: .create)
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            viewModel.deleteNote(offsets: offsets)
        }
    }
}

#Preview {
    NoteListView(viewModel: MockNoteListViewModel(targetStatus: .ready(Note.mockNotes()), viewContext:  PersistenceController.preview.container.viewContext))
}
