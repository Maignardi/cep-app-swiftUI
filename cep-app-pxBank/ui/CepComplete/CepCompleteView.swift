import SwiftUI

struct CepCompleteView: View {
    let address: Address
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("CEP: \(address.cep)")
            Text("Logradouro: \(address.logradouro)")
            Text("Complemento: \(address.complemento)")
            Text("Bairro: \(address.bairro)")
            Text("Localidade: \(address.localidade)")
            Text("UF: \(address.uf)")
            Text("IBGE: \(address.ibge)")
            Text("GIA: \(address.gia)")
            Text("DDD: \(address.ddd)")
            Text("SIAFI: \(address.siafi)")
        }
        .padding()
        .navigationBarTitle("Cep: \(address.cep)")
    }
}

struct CepCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleAddress = Address(cep: "12345-678", logradouro: "Rua Exemplo", complemento: "Complemento Exemplo", bairro: "Bairro Exemplo", localidade: "Cidade Exemplo", uf: "UF", ibge: "1234567", gia: "1234", ddd: "12", siafi: "1234")
        
        return CepCompleteView(address: exampleAddress)
    }
}

