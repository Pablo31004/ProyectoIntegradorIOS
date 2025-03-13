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
    @State private var aceptaTerminos = false  // Nuevo estado para el Toggle
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 400, height: 400)
                        .scaledToFit()
                        .scaledToFill()
                        .padding()
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
                
                Toggle(isOn: $aceptaTerminos) {
                    Text("Aceptar términos y condiciones")
                }
                .padding(.horizontal)
                
                Button(action: {
                    if aceptaTerminos {
                        authViewModel.iniciarSesion(email: email, contraseña: contraseña)
                    }
                }) {
                    Text("Iniciar Sesión")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(aceptaTerminos ? Color.blue : Color.gray) // Cambio de color según el estado
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(!aceptaTerminos) // Deshabilita el botón si no se aceptan términos
                
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
