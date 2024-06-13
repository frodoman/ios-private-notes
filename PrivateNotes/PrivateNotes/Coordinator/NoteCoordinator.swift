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
    }
}
