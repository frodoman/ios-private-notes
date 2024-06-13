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
                        //.onDelete(perform: deleteItems)
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
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Note(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { notes[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

#Preview {
    NoteListView(viewModel: MockNoteListViewModel(targetStatus: .ready(Note.mockNotes()), viewContext:  PersistenceController.preview.container.viewContext))
//        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
