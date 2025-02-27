//
//  CarritoView.swift
//  ProyectoIntegradorIOS
//
//  Created by Usuario invitado on 27/2/25.
//

import SwiftUI

struct CarritoView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if authViewModel.carrito.isEmpty {
                    Text("El carrito está vacío")
                        .font(.title2)
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(authViewModel.carrito) { item in
                            HStack {
                                Text(item.producto.nombre)
                                Spacer()
                                Text("x\(item.cantidad)")
                            }
                        }
                    }
                    HStack {
                        Text("Total:")
                            .font(.headline)
                        Spacer()
                        let total = authViewModel.carrito.reduce(0) { $0 + $1.producto.precio * Double($1.cantidad) }
                        Text("$\(String(format: "%.2f", total))")
                            .font(.headline)
                    }
                    .padding()
                    Button(action: {
                        authViewModel.finalizarCompra()
                    }) {
                        Text("Finalizar Compra")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle("Carrito")
        }
    }
}

struct CarritoView_Previews: PreviewProvider {
    static var previews: some View {
        CarritoView().environmentObject(AuthViewModel())
    }
}
