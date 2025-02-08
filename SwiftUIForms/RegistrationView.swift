//
//  RegistrationView.swift
//  SwiftUIForms
//
//  Created by Serhan Khan on 08/02/2025.
//

import SwiftUI

struct RegistrationView: View {
    
    @StateObject private var viewModel = RegistrationViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $viewModel.name)
                }
                
                Section(header: Text("Account Details")) {
                    TextField("Email", text: $viewModel.email)
                    
                    SecureField("Password", text: $viewModel.password)
                    
                    SecureField("Password Confirmation", text: $viewModel.confirmPassword)
                }
            }.safeAreaInset(edge: .bottom) {
                Button("Register") {
                    
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
