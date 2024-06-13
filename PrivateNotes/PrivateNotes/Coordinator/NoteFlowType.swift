//
//  NoteFlowType.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import Foundation
import Combine

enum NoteFlowType {
    case createNew
    case didSelect(Note)
    case didSave
}

typealias NoteFlowHandler = ((NoteFlowType)->Void)

