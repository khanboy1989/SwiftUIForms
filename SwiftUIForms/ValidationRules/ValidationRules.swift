//
//  ValidationRules.swift
//  SwiftUIForms
//
//  Created by Serhan Khan on 09/02/2025.
//

import Foundation

struct ValidationRules {
    static func validateName(_ name: String) -> String? {
        return name.isEmpty ? "Name is required" : nil
    }
    static func validateEmail(_ email: String) -> String? {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let isValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        return isValid ? nil : "Invalid email format"
    }

    static func validatePassword(_ password: String) -> String? {
        return password.count >= 6 ? nil : "Password must be at least 6 characters"
    }

    static func validateConfirmPassword(_ password: String, _ confirmPassword: String) -> String? {
        guard !confirmPassword.isEmpty else {
            return "Password confirmation is required"
        }
        return password == confirmPassword ? nil : "Passwords do not match"
    }
}

