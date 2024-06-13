//
//  CTALabel.swift
//  PrivateNotes
//
//  Created by Xinghou.Liu on 13/06/2024.
//

import SwiftUI

struct CTALabel: View {
    
    let title: String
    let radius: CGFloat
    let style: CTAStyle
    
    init(title: String,
         radius: CGFloat = 22,
         style: CTAStyle = .primary) {
        self.title = title
        self.radius = radius
        self.style = style
    }
    
    var body: some View {
        
        HStack {
            Spacer(minLength: 16)
            
            switch style {
            case .primary:
                Text(title)
                    .padding()
                    .frame(height: radius * 2.0)
                    .frame(maxWidth: .infinity)
                    .background(Color.ctaPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(radius)
            case .secondary:
                Text(title)
                    .padding()
                    .frame(height: radius * 2.0)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .foregroundColor(Color.ctaPrimary)
                    .cornerRadius(radius)
                    .overlay(RoundedRectangle(cornerRadius: radius)
                        .stroke(Color.ctaPrimary, lineWidth: 2))
            case .warning:
                Text(title)
                    .padding()
                    .frame(height: radius * 2.0)
                    .frame(maxWidth: .infinity)
                    .background(Color.error)
                    .foregroundColor(.white)
                    .cornerRadius(radius)
            }

            Spacer(minLength: 16)
        }
    }
}
