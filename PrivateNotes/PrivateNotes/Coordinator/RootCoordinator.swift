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
    let viewContext: NSManagedObjectContext
    
    @State var isAuthenticated: Bool = false
    
    init(navigationPath: NavigationPath,
         context: NSManagedObjectContext) {
        self.navigationPath = navigationPath
        self.viewContext = context
    }

    @ViewBuilder
    func view() -> some View {
        if isAuthenticated {
             RootView()
        } else {
            LoginView()
        }
    }
}

