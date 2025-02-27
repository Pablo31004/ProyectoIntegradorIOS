import SwiftUI

struct TiendaView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            List(authViewModel.productos) { producto in
                NavigationLink(destination: ProductDetailView(producto: producto)) {
                    HStack {
                        Image(producto.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(5)
                        VStack(alignment: .leading) {
                            Text(producto.nombre)
                                .font(.headline)
                            Text("$\(String(format: "%.2f", producto.precio))")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Tienda")
        }
    }
}

struct TiendaView_Previews: PreviewProvider {
    static var previews: some View {
        TiendaView().environmentObject(AuthViewModel())
    }
}

