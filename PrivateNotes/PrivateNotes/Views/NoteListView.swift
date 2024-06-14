//
//  ContentView.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 12/06/2024.
//

import SwiftUI
import CoreData

struct NoteListView<ViewModelType>: View where ViewModelType: NoteListViewModeling {
    
    @EnvironmentObject var rootCoordinator: RootCoordinator
    
    @ObservedObject
    var viewModel: ViewModelType
    
    var flowHandler: NoteFlowHandler?
    
    var body: some View {

        notesContentView()
        .onChange(of: rootCoordinator.isAuthenticated) { newValue in
            if newValue {
                self.viewModel.fetchNotes()
            }
        }
        .toolbar {
            ToolbarItem {
                Button("New", systemImage: "plus") {
                    self.flowHandler?(.createNew)
                }
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            viewModel.deleteNote(offsets: offsets)
        }
    }
    
    @ViewBuilder
    private func notesContentView() -> some View {
        VStack {
            switch (viewModel.status) {
                
            case .notStarted,
                 .fetching,
                 .deleted:
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                    Button {
                        viewModel.fetchNotes()
                    } label: {
                        CTALabel(title: "Refresh")
                    }

                }
               
            case .error(let error):
                ErrorView(error: error)
            
            case .ready(let notes):
                List {
                    ForEach(notes) { item in
                        Button(item.title ?? "") {
                            self.flowHandler?(.didSelect(item))
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                
            }
            Spacer()
            Text("Swipe to left on a cell to delete")
        }
    }
}

#Preview {
    NavigationView {
        NoteListView(viewModel: MockNoteListViewModel(targetStatus: .ready(Note.mockNotes()), viewContext:  PersistenceController.preview.container.viewContext))
    }
}
