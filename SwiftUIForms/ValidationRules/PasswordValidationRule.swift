//
//  PasswordValidationRule.swift
//  SwiftUIForms
//
//  Created by Serhan Khan on 18/02/2025.
//

import Foundation

/// A validation rule that checks if a password meets security requirements.
struct PasswordValidationRule: ValidationRule {
    typealias Input = String
    
    let errorMessage: String
    private let minLength: Int
    private let regex: String
    
    /// Initializes the `PasswordValidationRule` with a custom error message and minimum length.
    /// - Parameters:
    ///   - errorMessage: The message to display if validation fails.
    ///   - minLength: The required minimum password length.
    init(errorMessage: String = "Password must be at least 6 characters, include an uppercase letter, a number, and a special character.", minLength: Int = 6) {
        self.errorMessage = errorMessage
        self.minLength = minLength
        self.regex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{\(minLength),}$"
    }
    
    func validate(_ input: String) -> String? {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: input) ? nil : errorMessage
    }
}
