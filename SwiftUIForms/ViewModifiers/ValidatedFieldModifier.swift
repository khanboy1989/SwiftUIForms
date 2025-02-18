//
//  ValidatedFieldModifier.swift
//  SwiftUIForms
//
//  Created by Serhan Khan on 18/02/2025.
//

import SwiftUI

// A view modifier that attaches validation to a TextField.
struct ValidatedFieldModifier: ViewModifier {
    @ObservedObject var validatedField: ValidatedField
    let placeholder: String
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            content
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(validatedField.error == nil ? Color.gray : Color.red, lineWidth: 1)
                )
            
            if let error = validatedField.error {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
}

/// An extension to easily apply the ValidatedFieldModifier.
extension View {
    func validatedField(validatedField: ValidatedField, placeholder: String) -> some View {
        self.modifier(ValidatedFieldModifier(validatedField: validatedField, placeholder: placeholder))
    }
}
