//
//  ProyectoIntegradorIOSApp.swift
//  ProyectoIntegradorIOS
//
//  Created by Usuario invitado on 13/2/25.
//

import SwiftUI

@main
struct ProyectoIntegradorIOSApp: App {
    @StateObject var authViewModel = AuthViewModel() // Se crea la instancia global

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel) // Inyección en el entorno
        }
    }
}
