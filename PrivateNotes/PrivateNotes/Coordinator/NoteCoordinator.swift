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
    
    
    init(navigationPath: Binding<NavigationPath>,
         viewContext: NSManagedObjectContext) {
        self._navigationPath = navigationPath
        self.viewContext = viewContext
    }
    
    @ViewBuilder
    func view() -> some View {
        NoteListView(viewModel: NoteListViewModel(viewContext: viewContext)) { flowType in
            switch(flowType) {
            case .didSave,
                 .dismissDetails:
                break
            case .createNew:
                self.navigationPath.append(NoteDetailsPresentType.create)
                
            case .didSelect(let note):
                self.navigationPath.append(NoteDetailsPresentType.readOnly(note))
                
            }
        }
        .navigationDestination(for: NoteDetailsPresentType.self) { presentType in
            self.noteDetailsView(presentType: presentType)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    func noteDetailsView(presentType: NoteDetailsPresentType) -> some View {
        NoteDetailsView(viewModel: NoteDetailsViewModel(presentType: presentType,
                                                        viewContext: viewContext)) { type in
            switch type {
            case .dismissDetails,
                    .didSave:
                self.navigationPath.removeLast(self.navigationPath.count)
            default:
                break
            }
        }
    }
}
