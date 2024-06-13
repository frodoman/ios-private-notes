//
//  Note+Preview.swift
//  PrivateNotes
//
//  Created by X_coder on 12/06/2024.
//

import Foundation

extension Note {
    
    public convenience init(title: String,
                            content: String?) {

        let viewContext = PersistenceController.preview.container.viewContext
        self.init(context: viewContext)
        
        self.title = title
        self.content = content
        self.id = UUID()
        self.timestamp = Date()
    }
    
}
