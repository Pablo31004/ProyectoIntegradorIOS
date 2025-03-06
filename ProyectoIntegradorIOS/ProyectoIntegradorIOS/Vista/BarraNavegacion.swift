import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            TiendaView()
                .tabItem {
                    Label("Tienda", systemImage: "cart")
                }
            
            PedidosView()
                .tabItem {
                    Label("Pedidos", systemImage: "list.bullet")
                }
            
            CarritoView()
                .tabItem {
                    Label("Carrito", systemImage: "bag")
                }
            
            PerfilView()
                .tabItem {
                    Label("Perfil", systemImage: "person.crop.circle")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

