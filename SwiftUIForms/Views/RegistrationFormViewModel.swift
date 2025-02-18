//
//  RegistrationFormViewModel.swift
//  SwiftUIForms
//
//  Created by Serhan Khan on 18/02/2025.
//

import Combine
import SwiftUI

class RegistrationFormViewModel: ObservableObject {
    
    @Published var email: ValidatedField
    @Published var password: ValidatedField
    @Published var name: ValidatedField
    @Published var canSubmit: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        // Define validation rules for name
        let nameRules: [AnyValidationRule<String>] = [
            AnyValidationRule(EmptyValidationRule())
        ]
        
        // Define validation rules for email.
        let emailRules: [AnyValidationRule<String>] = [
            AnyValidationRule(EmptyValidationRule()),
            AnyValidationRule(EmailValidationRule())
        ]
        
        // Define validation rules for password.
        let passwordRules: [AnyValidationRule<String>] = [
            AnyValidationRule(EmptyValidationRule(errorMessage: "Password cannot be empty.")),
            AnyValidationRule(PasswordValidationRule(minLength: 8))
        ]
        

        // Initialize ValidatedFields with respective rules.
        self.name = ValidatedField(validationRules: nameRules)
        self.email = ValidatedField(validationRules: emailRules)
        self.password = ValidatedField(validationRules: passwordRules)
        
        self.setupSubmitValidation()
    }
    
    /// Sets up the logic to determine if the form can be submitted.
    private func setupSubmitValidation() {
        Publishers.CombineLatest(email.$error, password.$error)
            .map { emailError, passwordError in
                return emailError == nil && passwordError == nil && !self.email.value.isEmpty && !self.password.value.isEmpty
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellables)
    }
    
    /// Handles the login action.
    func regiter() {
        // Implement registration logic here.
        print("Registering with Name:\(name.value) Email: \(email.value) and Password: \(password.value)")
    }
}
