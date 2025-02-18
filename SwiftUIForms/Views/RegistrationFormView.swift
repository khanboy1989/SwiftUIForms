//
//  RegistrationFormView.swift
//  SwiftUIForms
//
//  Created by Serhan Khan on 18/02/2025.
//

import SwiftUI

struct RegistrationFormView: View {
    @StateObject private var viewModel = RegistrationFormViewModel()
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name, email, password, confirmPassword
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $viewModel.name.value)
                        .focused($focusedField, equals: .name)
                        .onSubmit { focusedField = .email }
                        .validatedField(validatedField: viewModel.name, placeholder: "Please insert your name")
                }
                
                Section(header: Text("Account Details")) {
                    TextField("Email", text: $viewModel.email.value)
                        .focused($focusedField, equals: .email)
                        .onSubmit { focusedField = .password }
                        .validatedField(validatedField: viewModel.email, placeholder: "Please insert email")
                    
                    
                    SecureField("Password", text: $viewModel.password.value)
                        .focused($focusedField, equals: .password)
                        .onSubmit { focusedField = .confirmPassword }
                        .validatedField(validatedField: viewModel.password, placeholder: "Please insert password")
                    
                }
                
            }.safeAreaInset(edge: .bottom) {
                Button("Register") {
                    viewModel.regiter()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal)
                .disabled(!viewModel.canSubmit)
            }
        }
    }
}
