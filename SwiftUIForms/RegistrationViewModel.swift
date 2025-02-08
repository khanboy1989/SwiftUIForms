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
    
}
