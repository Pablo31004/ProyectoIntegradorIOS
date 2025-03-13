//
//  AuthViewModel.swift
//  ProyectoIntegradorIOS
//
//  Created by Usuario invitado on 27/2/25.
//

import SwiftUI

// MARK: - Modelo de Usuario extendido
struct Usuario: Identifiable {
    let id = UUID()
    let email: String
    let contraseña: String
    let nombre: String
    let direccion: String
    var suscritoNewsletter: Bool
}

// Modelo de Producto
struct Producto: Identifiable, Codable {
    let id = UUID()
    let nombre: String
    let precio: Double
    let imageName: String
}

// Modelo de Pedido (histórico)
struct Pedido: Identifiable {
    let id = UUID()
    let producto: Producto
    let cantidad: Int
    let fecha: Date
}

// Modelo del Carrito (simula un item en el carrito)
struct CarritoItem: Identifiable {
    let id = UUID()
    let producto: Producto
    let cantidad: Int
}

// MARK: - ViewModel para Autenticación, Pedidos y Carrito
class AuthViewModel: ObservableObject {
    @Published var usuarioAutenticado: Usuario? = nil
    @Published var mensajeError: String = ""
    
    @Published var pedidos: [Pedido] = []       // Historial de pedidos
    @Published var carrito: [CarritoItem] = []  // Items del carrito
    @Published var productos: [Producto] = []   // Lista de productos desde JSON

    // Clave para almacenar dirección en UserDefaults
    private let DireccionUsuario = "direccionUsuario"

    // Lista de usuarios simulada
    private let usuariosRegistrados = [
        Usuario(email: "usuario1@mail.com", contraseña: "123", nombre: "Usuario Uno", direccion: "Calle Falsa 123", suscritoNewsletter: false),
        Usuario(email: "usuario2@mail.com", contraseña: "abcdef", nombre: "Usuario Dos", direccion: "Avenida Siempre Viva 742", suscritoNewsletter: false)
    ]
    
    // Inicializador que carga productos desde JSON
    init() {
        cargarProductosDesdeJSON()
    }

    // Función para cargar productos desde JSON
    func cargarProductosDesdeJSON() {
        guard let url = Bundle.main.url(forResource: "datos", withExtension: "json") else {
            print("No se encontró el archivo JSON")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode([String: [Producto]].self, from: data)
            self.productos = decodedData["platos"] ?? []
        } catch {
            print("Error al cargar los productos: \(error)")
        }
    }
    
    // Función de inicio de sesión
    func iniciarSesion(email: String, contraseña: String) {
        if let usuario = usuariosRegistrados.first(where: { $0.email == email && $0.contraseña == contraseña }) {
            // Cargar dirección desde UserDefaults (si existe)
            let direccionGuardada = UserDefaults.standard.string(forKey: DireccionUsuario) ?? usuario.direccion
            
            usuarioAutenticado = Usuario(
                email: usuario.email,
                contraseña: usuario.contraseña,
                nombre: usuario.nombre,
                direccion: direccionGuardada,
                suscritoNewsletter: usuario.suscritoNewsletter
            )
            
            mensajeError = ""
        } else {
            mensajeError = "Credenciales incorrectas"
        }
    }
    
    // Función de cierre de sesión
    func cerrarSesion() {
        usuarioAutenticado = nil
    }
    
    // Alternar el estado de suscripción a Newsletter
    func toggleNewsletter() {
        if let usuario = usuarioAutenticado {
            usuarioAutenticado = Usuario(
                email: usuario.email,
                contraseña: usuario.contraseña,
                nombre: usuario.nombre,
                direccion: usuario.direccion,
                suscritoNewsletter: !usuario.suscritoNewsletter
            )
        }
    }
    
    // Función para agregar un pedido (simula una compra) y vacía el carrito
    func finalizarCompra() {
        for item in carrito {
            let nuevoPedido = Pedido(producto: item.producto, cantidad: item.cantidad, fecha: Date())
            pedidos.append(nuevoPedido)
        }
        carrito.removeAll()
    }
    
    // Función para agregar un producto al carrito
    func agregarAlCarrito(producto: Producto, cantidad: Int) {
        let nuevoItem = CarritoItem(producto: producto, cantidad: cantidad)
        carrito.append(nuevoItem)
    }
    
    // Función para eliminar un producto del carrito
    func eliminarDelCarrito(item: CarritoItem) {
        carrito.removeAll { $0.id == item.id }
    }
    
    // Guardar dirección en el modelo y en UserDefaults
    func actualizarDireccion(_ nuevaDireccion: String) {
        if let usuario = usuarioAutenticado {
            usuarioAutenticado = Usuario(
                email: usuario.email,
                contraseña: usuario.contraseña,
                nombre: usuario.nombre,
                direccion: nuevaDireccion,
                suscritoNewsletter: usuario.suscritoNewsletter
            )
            
            // Guardar en UserDefaults para persistencia
            UserDefaults.standard.set(nuevaDireccion, forKey: DireccionUsuario)
        }
    }
}
