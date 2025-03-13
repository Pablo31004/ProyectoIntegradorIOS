//
//  PerfilView.swift
//  ProyectoIntegradorIOS
//
//  Created by Usuario invitado on 27/2/25.
//

import SwiftUI

struct PerfilView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var nuevaDireccion: String = ""
    @State private var mensajeExito: String = ""  // Mensaje de confirmación

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding()

                if let usuario = authViewModel.usuarioAutenticado {
                    Text(usuario.nombre)
                        .font(.title)
                    
                    TextField("Dirección", text: $nuevaDireccion)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .onAppear {
                            nuevaDireccion = usuario.direccion
                        }

                    Text(usuario.email)
                        .font(.subheadline)
                }

                Button(action: {
                    authViewModel.actualizarDireccion(nuevaDireccion)
                    mensajeExito = "Dirección guardada correctamente ✅"
                }) {
                    Text("Guardar Dirección")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                if !mensajeExito.isEmpty {
                    Text(mensajeExito)
                        .foregroundColor(.green)
                        .font(.caption)
                        .padding(.top, 5)
                }

                Toggle(isOn: Binding(
                    get: { authViewModel.usuarioAutenticado?.suscritoNewsletter ?? false },
                    set: { _ in authViewModel.toggleNewsletter() }
                )) {
                    Text("Suscribirse a la Newsletter")
                }
                .padding(.horizontal)

                Button(action: {
                    authViewModel.cerrarSesion()
                }) {
                    Text("Cerrar Sesión")
                        .foregroundColor(.red)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Perfil")
        }
    }
}

struct PerfilView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView().environmentObject(AuthViewModel())
    }
}


