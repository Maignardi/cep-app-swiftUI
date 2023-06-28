import SwiftUI

struct ConfigView: View {
    @State private var sendLogs: Bool = false
    @State private var sendLogsOption: Int = 0
    @State private var cep: String = ""
    var savedAddress: String? = ""
    
    @ObservedObject var viewModel: ConfigViewModel
    
    init(viewModel: ConfigViewModel = ConfigViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Enviar log das requisições para o Discord")
                .font(.title)
                .padding()
            
            VStack(alignment: .leading, spacing: 20) {
                RadioButtonField(id: 1, label: "Sim", isSelected: $sendLogsOption)
                RadioButtonField(id: 0, label: "Não", isSelected: $sendLogsOption)
                
                if let address = viewModel.loadLastAddress() {
                    Text("Último endereço salvo:")
                        .font(.headline)
                    Text("cep: \(address.cep)")
                        .foregroundColor(.gray)
                        .font(.body)
                } else {
                    Text("Nenhum endereço salvo")
                        .foregroundColor(.gray)
                        .font(.body)
                }
                
                Spacer()
                
                Button(action: {
                    sendLogs = sendLogsOption == 0
                    viewModel.sendCEPToDiscord()
                }) {
                    Text("Enviar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(sendLogsOption == 0)
                .opacity(Double(sendLogsOption))
            }
            .padding()
            
            Spacer()
        }
        .background(Color.white)
        .onAppear() {
            DispatchQueue.main.async {
                viewModel.loadLastAddress()
            }
        }
    }
    
    struct RadioButtonField: View {
        let id: Int
        let label: String
        @Binding var isSelected: Int
        
        var body: some View {
            Button(action: {
                isSelected = id
            }) {
                HStack(spacing: 10) {
                    Image(systemName: isSelected == id ? "largecircle.fill.circle" : "circle")
                        .foregroundColor(isSelected == id ? .blue : .gray)
                        .imageScale(.large)
                    
                    Text(label)
                        .font(.headline)
                }
            }
        }
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
