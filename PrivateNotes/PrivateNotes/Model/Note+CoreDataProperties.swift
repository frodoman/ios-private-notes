//
//  Note+CoreDataProperties.swift
//  PrivateNotes
//
//  Created by X_coder on 12/06/2024.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var id: UUID?

}

extension Note : Identifiable {

}
