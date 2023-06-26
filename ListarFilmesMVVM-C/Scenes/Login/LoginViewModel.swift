//
//  LoginViewModel.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 15/06/23.
//

import Foundation
import FirebaseAuth


protocol LoginViewActionsDelegate: AnyObject {
    func activateAnimating(activate: Bool)
    func showAlert(title: String, message: String)
    func cleanTextFields()
}

protocol LoginViewModelDelegate: AnyObject {
    var delegate: LoginViewActionsDelegate? { get set }
    func tryLogin(login: String, senha: String)
    func goToScreenCreateLogin()
    func goToScreenResetLogin()
}

class LoginViewModel: LoginViewModelDelegate {
    
    weak var delegate: LoginViewActionsDelegate?
    var loginCoordinator: LoginCoordinatorDelegate?
    var loginservice: LoginService?
    var listFilms: [Result] = []

    
    func tryLogin(login: String, senha: String) {
        Auth.auth().signIn(withEmail: login, password: senha) { [weak self] authResult, error in
                        
            if let error = error as? NSError{
                if error.code == 17009 {
                    self?.delegate?.showAlert(title: ProjectStrings.invalidPassword.localized,
                                              message: ProjectStrings.invalidPasswordMessage.localized)
                }
                if error.code == 17011 {
                    self?.delegate?.showAlert(title: ProjectStrings.userNotFound.localized,
                                              message: ProjectStrings.userNotFoundMessage.localized)
                }
                if error.code == 17008 {
                    self?.delegate?.showAlert(title: ProjectStrings.incorrectEmailFormat.localized,
                                              message: ProjectStrings.incorrectEmailFormatMessage.localized)
                }
                self?.delegate?.activateAnimating(activate: false)
                return
            }
            self?.searchFilmList()
        }
    }
    
    func searchFilmList() {
        self.delegate?.activateAnimating(activate: false)
        // Defina a URL da API e a chave de API
        let apiKey = "ac894a60b6f5b4abf7ff6c58dbc67ced"
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        
        // Crie uma instância de URLSession
        let session = URLSession.shared
        
        // Crie uma instância de URLRequest com a URL da API
        guard let url = URL(string: urlString) else { return }
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
                let result = try decoder.decode(FilmModel.self, from: data)
                self.listFilms = result.results
                self.getListFilms()
            
            } catch {
                print("Erro ao converter dados em JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func getListFilms() {
        delegate?.cleanTextFields()
        goToScreenListFilms()
    }
    
    func goToScreenListFilms() {
        loginCoordinator?.goesToListFilm(result: self.listFilms)
    }
    
    func goToScreenCreateLogin() {
        loginCoordinator?.goesToCreateFilm()
    }
    
    func goToScreenResetLogin() {
        loginCoordinator?.goesToResetFilm()
    }
}

