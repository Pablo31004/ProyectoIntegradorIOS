//
//  PerfilView.swift
//  ProyectoIntegradorIOS
//
//  Created by Usuario invitado on 27/2/25.
//

import SwiftUI

struct PerfilView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Imagen de perfil por defecto
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding()
                // Datos del usuario
                if let usuario = authViewModel.usuarioAutenticado {
                    Text(usuario.nombre)
                        .font(.title)
                    Text(usuario.direccion)
                        .font(.subheadline)
                    Text(usuario.email)
                        .font(.subheadline)
                }
                // Toggle para Newsletter
                Toggle(isOn: Binding(
                    get: {
                        authViewModel.usuarioAutenticado?.suscritoNewsletter ?? false
                    },
                    set: { _ in
                        authViewModel.toggleNewsletter()
                    }
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
