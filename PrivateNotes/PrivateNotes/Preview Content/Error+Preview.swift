//
//  Error+Preview.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import Foundation
import Combine

enum MockError: Error {
    case FailedCreateNote
    case FailedReadingNotes
    case FailedUpdateNote
    case FailedDeleteNote
    case FailedLogin
}

