//
//  ProyectoIntegradorIOSApp.swift
//  ProyectoIntegradorIOS
//
//  Created by Usuario invitado on 13/2/25.
//

import SwiftUI

@main
struct ProyectoIntegradorIOSApp: App {
    @StateObject var authViewModel = AuthViewModel() // Creamos la instancia del ViewModel

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel) // Inyectamos el EnvironmentObject
        }
    }
}
