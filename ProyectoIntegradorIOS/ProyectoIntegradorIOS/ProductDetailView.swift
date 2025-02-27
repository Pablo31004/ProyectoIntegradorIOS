//
//  ProductDetailView.swift
//  ProyectoIntegradorIOS
//
//  Created by Usuario invitado on 27/2/25.
//

import SwiftUI

struct ProductDetailView: View {
    let producto: Producto
    @State private var cantidad: Int = 1
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            Image(producto.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            Text(producto.nombre)
                .font(.largeTitle)
            Text("$\(String(format: "%.2f", producto.precio))")
                .font(.title2)
            Stepper("Cantidad: \(cantidad)", value: $cantidad, in: 1...10)
                .padding()
            Button(action: {
                authViewModel.agregarAlCarrito(producto: producto, cantidad: cantidad)
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Text("Agregar al Carrito")
                    Spacer()
                    Text("$\(String(format: "%.2f", producto.precio * Double(cantidad)))")
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            Spacer()
        }
        .padding()
        .navigationTitle(producto.nombre)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(producto: Producto(nombre: "Hamburguesa", precio: 8.50, imageName: "hamburguesa"))
            .environmentObject(AuthViewModel())
    }
}
