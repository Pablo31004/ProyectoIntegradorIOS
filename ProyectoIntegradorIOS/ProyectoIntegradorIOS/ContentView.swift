//
//  ContentView.swift
//  ProyectoIntegradorIOS
//
//  Created by Usuario invitado on 13/2/25.
//

import SwiftUI

// Modelo de usuario
struct Usuario {
    let email: String
    let contraseña: String
}

// Lista de usuarios simulada
let usuariosRegistrados = [
    Usuario(email: "usuario1@mail.com", contraseña: "123"),
    Usuario(email: "usuario2@mail.com", contraseña: "abcdef")
]

// Vista de Login
struct LoginView: View {
    @State private var email = ""
    @State private var contraseña = ""
    @State private var mostrarInicio = false
    @State private var mensajeError = " "

    var body: some View {
        NavigationView {
            VStack {
                Text("Bienvenido a VirtualBites")
                    .font(.title3)
                    .padding(.bottom, 20)

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                SecureField("Contraseña", text: $contraseña)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                if !mensajeError.isEmpty {
                    Text(mensajeError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 5)
                }

                Button(action: iniciarSesion) {
                    Text("Iniciar Sesión")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.top, 10)

                NavigationLink(destination: MainTabView(), isActive: $mostrarInicio) {
                    EmptyView()
                }
            }
            .padding()
        }
    }

    // Función de autenticación
    func iniciarSesion() {
        if let _ = usuariosRegistrados.first(where: { $0.email == email && $0.contraseña == contraseña }) {
            mostrarInicio = true
        } else {
            mensajeError = "Credenciales incorrectas"
        }
    }
}

// TabView para la estructura principal
struct MainTabView: View {
    var body: some View {
        TabView {
            TiendaView()
                .tabItem {
                    Label("Tienda", systemImage: "cart")
                }
            PerfilView()
                .tabItem {
                    Label("Perfil", systemImage: "person.crop.circle")
                }
        }
    }
}

// Vista de la tienda
struct TiendaView: View {
    var body: some View {
        VStack {
            Text("Tienda VirtualBites")
                .font(.largeTitle)
        }
    }
}

// Vista del perfil
struct PerfilView: View {
    var body: some View {
        VStack {
            Text("Perfil del Usuario")
                .font(.largeTitle)
        }
    }
}

// Vista principal
@main
struct VirtualBitesApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
