//
//  RootCoordinator.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import CoreData
import SwiftUI

final class RootCoordinator: ObservableObject {
    @Published var navigationPath: NavigationPath
    
    @Published var isAuthenticated: Bool = false
    let viewContext: NSManagedObjectContext
    
    init(navigationPath: NavigationPath,
         context: NSManagedObjectContext) {
        self.navigationPath = navigationPath
        self.viewContext = context
    }

    @ViewBuilder
    func view() -> some View {
        
        ContentView()

    }
}

