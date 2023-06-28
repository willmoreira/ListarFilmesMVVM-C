//
//  LoginService.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit
import FirebaseAuth

class LoginService {
    
    var listFilms: [Result] = []

    func signIn(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            completion(authDataResult, error)
        }
    }
    
    func doRequestListFilms(completion: @escaping ([Result]) -> Void) {
        guard let configPath = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let configDictionary = NSDictionary(contentsOfFile: configPath),
              let apiKey = configDictionary["API_KEY"] as? String else {
            fatalError("Arquivo de configuração 'Config.plist' não encontrado ou chave 'API_KEY' ausente.")
        }
        
        let urlString = ProjectStrings.urlString.localized + apiKey
        
        // Crie uma instância de URLSession
        let session = URLSession.shared
        
        // Crie uma instância de URLRequest com a URL da API
        guard let url = URL(string: urlString) else {
            fatalError("URL inválida")
        }
        var request = URLRequest(url: url)
        
        // Defina o método HTTP da requisição como GET
        request.httpMethod = "GET"
        
        // Crie uma task de data para enviar a requisição
        let task = session.dataTask(with: request) { data, response, error in
            // Verifique se houve um erro
            if let error = error {
                print("Erro: \(error.localizedDescription)")
                return
            }
            // Verifique se há dados na resposta
            guard let data = data else {
                print("Não há dados na resposta")
                return
            }
            // Converta os dados em um objeto JSON
            do {
                let decoder = JSONDecoder()
                let filmModel = try decoder.decode(FilmModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(filmModel.results)
                }
            } catch {
                print("Erro ao converter dados em JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
