//
//  CreateLoginViewModel.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit
import FirebaseAuth

protocol CreateLoginViewActionsDelegate: AnyObject {
    func activateAnimating(activate: Bool)
    func showAlert(title: String, message: String, result: Bool)
}

protocol CreateLoginViewModelDelegate: AnyObject {
    var delegate: CreateLoginViewActionsDelegate? { get set }
    func tryCreateLogin(login: String, password: String)
}

class CreateLoginViewModel: CreateLoginViewModelDelegate {
    weak var delegate: CreateLoginViewActionsDelegate?

    func tryCreateLogin(login: String, password: String) {
        Auth.auth().createUser(withEmail: login, password: password) { authResult, error in
            self.delegate?.activateAnimating(activate: false)
            if let error = error {
                if error.localizedDescription == "The email address is already in use by another account." {
                    self.delegate?.showAlert(title: "Email já em uso!", message: "O endereço de e-mail já está sendo usado por outra conta.", result: false)
                }
                if error.localizedDescription == "The email address is badly formatted." {
                    self.delegate?.showAlert(title: "Formato do email incorreto!", message: "O endereço de e-mail não parece ser valido", result: false)
                }
                if error.localizedDescription == "The password must be 6 characters long or more." {
                    self.delegate?.showAlert(title: "Regra de senha", message: "A senha deve ter 6 caracteres ou mais.", result: false)
                }
                return
            }
            self.delegate?.showAlert(title: "Sucesso!",
                               message: "Usuario cadastrado com sucesso, faça o Login agora!",
                               result: true)
        }
    }
}
