//
//  LoginView.swift
//  ProyectoIntegradorIOS
//
//  Created by Usuario invitado on 27/2/25.
//

import SwiftUI
struct LoginView: View {
    @State private var email = ""
    @State private var contraseña = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack{
                    Image("logo")
                        .resizable()
                        .frame(width: 400, height: 400)
                        .scaledToFit()
                        .scaledToFill()
                }
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                SecureField("Contraseña", text: $contraseña)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                if !authViewModel.mensajeError.isEmpty {
                    Text(authViewModel.mensajeError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 5)
                }
                
                Button(action: {
                    authViewModel.iniciarSesion(email: email, contraseña: contraseña)
                }) {
                    Text("Iniciar Sesión")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthViewModel())
    }
}
