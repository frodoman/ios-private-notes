//
//  LAContexting.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 15/06/2024.
//

import Foundation
import LocalAuthentication

protocol LAContexting {
    func canEvaluatePolicy(_ policy: LAPolicy, error: NSErrorPointer) -> Bool
    func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void)
}

extension LAContext: LAContexting {
    
}
