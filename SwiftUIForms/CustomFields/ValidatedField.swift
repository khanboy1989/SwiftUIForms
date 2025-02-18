//
//  ValidatedField.swift
//  SwiftUIForms
//
//  Created by Serhan Khan on 18/02/2025.
//

import SwiftUI
import Combine

/// An observable field that handles validation for user input.
class ValidatedField: ObservableObject {
    @Published var value: String = ""
    @Published var error: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let validationRules: [AnyValidationRule<String>]
    
    /// Initializes the `ValidatedField` with an array of validation rules.
    /// - Parameter validationRules: The validation rules to apply.
    init(validationRules: [AnyValidationRule<String>]) {
        self.validationRules = validationRules
        setupValidation()
    }
    
    /// Observes changes to the value and triggers validation.
    private func setupValidation() {
        $value
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main) // Reduce unnecessary validations
            .removeDuplicates()
            .sink { [weak self] newValue in
                self?.error = self?.validate(newValue)
            }
            .store(in: &cancellables)
    }
    
    /// Validates the current value against all assigned validation rules.
    /// - Parameter value: The value to validate.
    /// - Returns: An optional error message if validation fails.
    private func validate(_ value: String) -> String? {
        for rule in validationRules {
            if let error = rule.validate(value) {
                return error
            }
        }
        return nil
    }
}
