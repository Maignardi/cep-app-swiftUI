import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .cep
    
    enum Tab {
        case cep
        case configuracao
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SearchCepView()
                .tabItem {
                    Image(systemName: "location.circle.fill")
                    Text("Cep")
                }
                .tag(Tab.cep)
            
            ConfigView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Configuração")
                }
                .tag(Tab.configuracao)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
