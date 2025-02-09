//
//  RegistrationView.swift
//  SwiftUIForms
//
//  Created by Serhan Khan on 08/02/2025.
//

import SwiftUI

struct RegistrationView: View {
    
    @StateObject private var viewModel = RegistrationViewModel()
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name, email, password, confirmPassword
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $viewModel.name)
                        .focused($focusedField, equals: .name)
                        .onSubmit { focusedField = .email }
                        .onChange(of: viewModel.name) { oldValue, newValue in
                            viewModel.validateName()
                        }
                    
                    if let nameError = viewModel.nameError {
                        Text(nameError).foregroundColor(.red)
                    }
                }
                
                Section(header: Text("Account Details")) {
                    TextField("Email", text: $viewModel.email)
                        .focused($focusedField, equals: .email)
                        .onSubmit { focusedField = .password }
                        .onChange(of: viewModel.email) { oldValue, newValue in
                            viewModel.validateEmail()
                        }
                    
                    if let emailError = viewModel.emailError {
                        Text(emailError).foregroundColor(.red)
                    }
                    
                    SecureField("Password", text: $viewModel.password)
                        .focused($focusedField, equals: .password)
                        .onSubmit { focusedField = .confirmPassword }
                        .onChange(of: viewModel.password) { oldValue, newValue in
                            viewModel.validatePassword()
                        }
                    
                    if let passwordError = viewModel.passwordError {
                        Text(passwordError).foregroundColor(.red)
                    }
                    
                    SecureField("Password Confirmation", text: $viewModel.confirmPassword)
                        .focused($focusedField, equals: .confirmPassword)
                        .onSubmit { focusedField = nil }
                        .onChange(of: viewModel.confirmPassword) { oldValue, newValue in
                            viewModel.validateConfirmPassword()
                        }
                    
                    if let confirmPasswordError = viewModel.confirmPasswordError {
                        Text(confirmPasswordError).foregroundColor(.red)
                    }
                }
                
                Section(header: Text("Validation Result")) {
                    Text("Validation Result = \(viewModel.isValid)")
                }
            }.safeAreaInset(edge: .bottom) {
                Button("Register") {
                    viewModel.validateForm()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    RegistrationView()
}
