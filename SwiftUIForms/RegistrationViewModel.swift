//
//  Untitled.swift
//  SwiftUIForms
//
//  Created by Serhan Khan on 08/02/2025.
//
import Foundation

final class RegistrationViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var nameError: String?
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var confirmPasswordError: String?
    
    var isValid: Bool {
        return nameError == nil &&
        emailError == nil &&
        passwordError == nil &&
        confirmPasswordError == nil &&
        !name.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        !confirmPassword.isEmpty
    }

    func validateName() {
        nameError = ValidationRules.validateName(name)
    }

    func validateEmail() {
        emailError = ValidationRules.validateEmail(email)
    }

    func validatePassword() {
        passwordError = ValidationRules.validatePassword(password)
    }

    func validateConfirmPassword() {
        confirmPasswordError = ValidationRules.validateConfirmPassword(password, confirmPassword)
    }
    
    func validateForm() {
        validateName()
        validateEmail()
        validatePassword()
        validateConfirmPassword()
    }
    
}
