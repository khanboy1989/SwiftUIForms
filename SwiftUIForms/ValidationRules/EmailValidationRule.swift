//
//  EmailValidationRule.swift
//  SwiftUIForms
//
//  Created by Serhan Khan on 18/02/2025.
//

import Foundation

/// A validation rule that checks if a string is a valid email address.
struct EmailValidationRule: ValidationRule {
    typealias Input = String
    let errorMessage: String
    
    /// Initializes the `EmailValidationRule` with a custom error message.
    /// - Parameter errorMessage: The message to display if validation fails.
    init(errorMessage: String = "Please enter a valid email address.") {
        self.errorMessage = errorMessage
    }
    
    func validate(_ input: String) -> String? {
        // Simple regex for email validation.
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: input) ? nil : errorMessage
    }
}
