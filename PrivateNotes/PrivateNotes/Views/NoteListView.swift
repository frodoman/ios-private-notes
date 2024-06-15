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
    
    @ObservedObject var viewModel: ViewModelType
    
    var flowHandler: NoteFlowHandler?
    
    var body: some View {

        notesContentView()
        .toolbar {
            ToolbarItem {
                Button("New", systemImage: "plus") {
                    flowHandler?(.createNew)
                }
            }
        }
        .onAppear {
            if rootCoordinator.isAuthenticated {
                viewModel.fetchNotes()
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
                 .fetching:
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                    refreshButton()
                }
               
            case .error(let error):
                ErrorView(error: error)
            
            case .ready(let notes):
                List {
                    ForEach(notes) { item in
                        Button(item.title ?? "") {
                            flowHandler?(.didSelect(item))
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            case .deleted(let indexes):
                VStack {
                    Spacer()
                    CTALabel(title: "Note deleted: \(indexes)",
                             style: .secondary)
                    Spacer()
                    refreshButton()
                }
            }
            Spacer()
            Text("Swipe to left on a cell to delete")
        }
    }
    
    @ViewBuilder
    func refreshButton() -> some View {
        Button {
            viewModel.fetchNotes()
        } label: {
            CTALabel(title: "Refresh")
        }
    }
}

#Preview {
    NavigationView {
        NoteListView(viewModel: MockNoteListViewModel(targetStatus: .ready(Note.mockNotes()), viewContext:  PersistenceController.preview.container.viewContext))
    }
}
