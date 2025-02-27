import SwiftUI

// MARK: - Modelo de Usuario

struct Usuario: Identifiable {
    let id = UUID()
    let email: String
    let contraseña: String
}

// MARK: - ViewModel de Autenticación

class AuthViewModel: ObservableObject {
    @Published var usuarioAutenticado: Usuario? = nil
    @Published var mensajeError: String = ""
    
    // Lista de usuarios simulada
    private let usuariosRegistrados = [
        Usuario(email: "usuario1@mail.com", contraseña: "123"),
        Usuario(email: "usuario2@mail.com", contraseña: "abcdef")
    ]
    
    func iniciarSesion(email: String, contraseña: String) {
        if let usuario = usuariosRegistrados.first(where: { $0.email == email && $0.contraseña == contraseña }) {
            usuarioAutenticado = usuario
            mensajeError = ""
        } else {
            mensajeError = "Credenciales incorrectas"
        }
    }
    
    func cerrarSesion() {
        usuarioAutenticado = nil
    }
}

// MARK: - Vista de Login

struct LoginView: View {
    @State private var email = ""
    @State private var contraseña = ""
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Bienvenido a VirtualBites")
                    .font(.title)
                    .padding(.bottom, 20)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                SecureField("Contraseña", text: $contraseña)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                if !authViewModel.mensajeError.isEmpty {
                    Text(authViewModel.mensajeError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 5)
                }
                
                Button(action: {
                    authViewModel.iniciarSesion(email: email, contraseña: contraseña)
                }) {
                    Text("Iniciar Sesión")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Login")
        }
    }
}

// MARK: - Vista Principal con TabView

struct MainTabView: View {
    var body: some View {
        TabView {
            TiendaView()
                .tabItem {
                    Label("Tienda", systemImage: "cart")
                }
            
            PerfilView()
                .tabItem {
                    Label("Perfil", systemImage: "person.crop.circle")
                }
        }
    }
}

// MARK: - Vista de Tienda

struct TiendaView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Tienda VirtualBites")
                    .font(.largeTitle)
                    .padding()
                // Aquí puedes agregar la lista de productos
                Spacer()
            }
            .navigationTitle("Tienda")
        }
    }
}

// MARK: - Vista del Perfil

struct PerfilView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Perfil del Usuario")
                    .font(.largeTitle)
                
                if let usuario = authViewModel.usuarioAutenticado {
                    Text("Email: \(usuario.email)")
                        .font(.title2)
                }
                
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

// MARK: - Vista Principal que Controla el Flujo

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        if authViewModel.usuarioAutenticado == nil {
            LoginView()
        } else {
            MainTabView()
        }
    }
}
