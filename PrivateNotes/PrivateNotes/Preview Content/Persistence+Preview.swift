//
//  PersistenceController+Preview.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 12/06/2024.
//

import CoreData

extension PersistenceController {
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for index in 0..<10 {
            let newItem = Note(context: viewContext)
            newItem.timestamp = Date()
            newItem.id = UUID()
            newItem.title = "Title: " + String(index)
            newItem.content = "Content: " + String(index)
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
