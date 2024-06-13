//
//  ErrorView.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import SwiftUI

struct ErrorView: View {
    
    let error: Error
    
    var body: some View {
        VStack {
            Text(error.localizedDescription)
                .padding()
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    ErrorView(error: MockError.FailedReadingNotes)
}
