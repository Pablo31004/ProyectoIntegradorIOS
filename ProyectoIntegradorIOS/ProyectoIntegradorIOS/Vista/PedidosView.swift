//
//  PedidosView.swift
//  ProyectoIntegradorIOS
//
//  Created by Usuario invitado on 27/2/25.
//

import SwiftUI

struct PedidosView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            List(authViewModel.pedidos) { pedido in
                VStack(alignment: .leading) {
                    Text(pedido.producto.nombre)
                        .font(.headline)
                    Text("Cantidad: \(pedido.cantidad)")
                    Text("Fecha: \(pedido.fecha, formatter: pedidoFormatter)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Pedidos")
        }
    }
}

private let pedidoFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

struct PedidosView_Previews: PreviewProvider {
    static var previews: some View {
        PedidosView().environmentObject(AuthViewModel())
    }
}
