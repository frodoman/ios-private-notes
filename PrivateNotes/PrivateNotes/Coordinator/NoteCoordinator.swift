//
//  NoteCoordinator.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import SwiftUI
import CoreData

final class NoteCoordinator: ObservableObject {
    
    @Binding var navigationPath: NavigationPath
    
    let viewContext: NSManagedObjectContext
    let listViewModel: NoteListViewModel
    
    init(navigationPath: Binding<NavigationPath>,
         viewContext: NSManagedObjectContext) {
        self._navigationPath = navigationPath
        self.viewContext = viewContext
        self.listViewModel = NoteListViewModel(viewContext: viewContext)
    }
    
    @ViewBuilder
    func view() -> some View {
        NoteListView(viewModel: listViewModel) { flowType in
            switch(flowType) {
            case .didSave:
                self.navigationPath.removeLast()
            case .createNew:
                self.navigationPath.append(NoteDetailsPresentType.create)
                
            case .didSelect(let note):
                self.navigationPath.append(NoteDetailsPresentType.readOnly(note))
                
            }
        }
        .navigationDestination(for: NoteDetailsPresentType.self) { presentType in
            self.noteDetailsView(presentType: presentType)
        }
    }
    
    @ViewBuilder
    func noteDetailsView(presentType: NoteDetailsPresentType) -> some View {
        NoteDetailsView(viewModel: NoteDetailsViewModel(presentType: presentType,
                                                        viewContext: PersistenceController.viewContext)) { type in
            if case .didSave = type {
                self.navigationPath.removeLast()
            }
        }
    }
}
