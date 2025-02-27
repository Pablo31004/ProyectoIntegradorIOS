//
//  BaseDatos.swift
//  ProyectoIntegradorIOS
//
//  Created by Usuario invitado on 27/2/25.
//

import Foundation


// Para el JSON de platos (menú)
struct PlatosData: Codable {
    let platos: [PlatoJSON]
}

struct PlatoJSON: Codable {
    let nombre: String
    let ingredientes: [String]
    let valor_nutricional: ValorNutricionalJSON
}

struct ValorNutricionalJSON: Codable {
    let calorias: Int
    let proteinas: Int
    let carbohidratos: Int
    let grasas: Int
}

// Para el JSON de pedido
struct PedidoData: Codable {
    let id_pedido: Int
    let usuario: PedidoUsuarioJSON
    let items: [PedidoItemJSON]
    let total: Double
    let metodo_pago: String
    let estado: String
    let fecha: String  // Se puede convertir a Date si se necesita
}

struct PedidoUsuarioJSON: Codable {
    let id_usuario: Int
    let nombre: String
    let direccion: String
    let telefono: String
}

struct PedidoItemJSON: Codable {
    let id_producto: Int
    let nombre: String
    let cantidad: Int
    let precio_unitario: Double
    let subtotal: Double
}

// Para el JSON de carrito
struct CarritoData: Codable {
    let id_carrito: Int
    let usuario: CarritoUsuarioJSON
    let items: [CarritoItemJSON]
    let total: Double
}

struct CarritoUsuarioJSON: Codable {
    let id_usuario: Int
    let nombre: String
}

struct CarritoItemJSON: Codable {
    let id_producto: Int
    let nombre: String
    let cantidad: Int
    let precio_unitario: Double
    let subtotal: Double
}

// MARK: - Clase Controlador para Conectar la "Base de Datos" (JSON) con la Aplicación

class Controlador {
    // Usamos un singleton para poder acceder fácilmente desde cualquier parte de la app.
    static let shared = Controlador()
    
    private init() { }
    
    /// Carga los datos de los platos desde el archivo JSON "platos.json" incluido en el Bundle.
    func cargarPlatos() -> [PlatoJSON]? {
        guard let url = Bundle.main.url(forResource: "platos", withExtension: "json") else {
            print("No se encontró el archivo platos.json")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            let platosData = try JSONDecoder().decode(PlatosData.self, from: data)
            return platosData.platos
        } catch {
            print("Error al decodificar platos: \(error)")
            return nil
        }
    }
    
    /// Carga los datos de un pedido desde el archivo JSON "pedido.json" incluido en el Bundle.
    func cargarPedido() -> PedidoData? {
        guard let url = Bundle.main.url(forResource: "pedido", withExtension: "json") else {
            print("No se encontró el archivo pedido.json")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            let pedidoData = try JSONDecoder().decode(PedidoData.self, from: data)
            return pedidoData
        } catch {
            print("Error al decodificar pedido: \(error)")
            return nil
        }
    }
    
    func cargarCarrito() -> CarritoData? {
        guard let url = Bundle.main.url(forResource: "carrito", withExtension: "json") else {
            print("No se encontró el archivo carrito.json")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            let carritoData = try JSONDecoder().decode(CarritoData.self, from: data)
            return carritoData
        } catch {
            print("Error al decodificar carrito: \(error)")
            return nil
        }
    }
}
