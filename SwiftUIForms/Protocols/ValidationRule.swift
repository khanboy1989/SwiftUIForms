//
//  ValidationRule.swift
//  SwiftUIForms
//
//  Created by Serhan Khan on 18/02/2025.
//

import Foundation

/// A protocol that defines a validation rule for a specific type of input.
protocol ValidationRule {
    associatedtype Input
    
    /// Validates the given input.
    /// - Parameter input: The input to validate.
    /// - Returns: An optional error message if validation fails.
    func validate(_ input: Input) -> String?
}
