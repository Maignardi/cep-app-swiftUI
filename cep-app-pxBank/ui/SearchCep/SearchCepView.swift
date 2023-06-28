import SwiftUI

struct SearchCepView: View {
    @ObservedObject var viewModel: SearchCepViewModel
    
    @State private var showAlert: Bool = false
    @State private var showResult: Bool = false
    
    init(viewModel: SearchCepViewModel = SearchCepViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Digite o CEP", text: $viewModel.cep)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    viewModel.fetchAddress()
                }) {
                    Text("Buscar")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
                
                NavigationLink(
                    destination: CepCompleteView(address: viewModel.address ?? Address(cep: "", logradouro: "", complemento: "", bairro: "", localidade: "", uf: "", ibge: "", gia: "", ddd: "", siafi: "")),
                    isActive: $viewModel.showResult
                ) {
                    EmptyView()
                }
                .hidden()
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Digite o CEP")
            .onAppear {
                viewModel.cep = ""
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Erro"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}


struct SearchCepView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCepView()
    }
}
