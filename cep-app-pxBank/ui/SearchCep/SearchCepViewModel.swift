import Foundation

class SearchCepViewModel: ObservableObject {
    @Published var cep: String = ""
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var address: Address?
    @Published var showResult: Bool = false
    
    func fetchAddress() {
        guard let url = URL(string: "https://viacep.com.br/ws/\(cep)/json/") else { return }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.showAlert = true
                    self.alertMessage = "Ocorreu um erro ao buscar o endereço."
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let address = try decoder.decode(Address.self, from: data)
                
                DispatchQueue.main.async {
                    self.address = address
                    self.isLoading = false
                    self.showResult = true
                    
                    // Save address in UserDefaults
                    do {
                        let addressData = try JSONEncoder().encode(address)
                        UserDefaults.standard.set(addressData, forKey: "savedAddress")
                    } catch {
                        print("Error encoding address: \(error.localizedDescription)")
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.showAlert = true
                    self.alertMessage = "CEP inválido. Verifique o CEP digitado e tente novamente."
                }
                print("Error decoding address: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func loadLastAddress() {
        if let addressData = UserDefaults.standard.data(forKey: "savedAddress") {
            do {
                let address = try JSONDecoder().decode(Address.self, from: addressData)
                self.address = address
                self.showResult = true
            } catch {
                print("Error decoding last address: \(error.localizedDescription)")
            }
        }
    }
}
