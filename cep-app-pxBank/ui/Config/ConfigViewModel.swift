import Foundation

class ConfigViewModel: ObservableObject {
    
    func sendCEPToDiscord() {
        let webhookURLString = "https://discord.com/api/webhooks/1095399212310593597/wI4rSHU4bI3jGTz7XoV3LCKJ7licceu4_bz2G3yJt8bN9aHSIdE6ZSdF6UTDPjW8fEiP"
        let message = "{\"content\": \"\(String(describing: loadLastAddress()))\"}"
        
        guard let webhookURL = URL(string: webhookURLString) else {
            print("URL do webhook inválida")
            return
        }
        
        var request = URLRequest(url: webhookURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = message.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Erro ao enviar o CEP para o Discord: \(error.localizedDescription)")
            } else {
                print(message)
                print("CEP enviado para o Discord com sucesso")
            }
        }.resume()
    }
    
    func loadLastAddress() -> Address? {
        if let addressData = UserDefaults.standard.data(forKey: "savedAddress") {
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let address = try decoder.decode(Address.self, from: addressData)
                return address
            } catch {
                print("Erro ao decodificar o endereço salvo: \(error.localizedDescription)")
            }
        } else {
            print("Nenhum endereço salvo encontrado")
        }
        
        return nil
    }
}
