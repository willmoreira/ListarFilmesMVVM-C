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
    
    func tryLogin(login: String, senha: String) {
        Auth.auth().signIn(withEmail: login, password: senha) { [weak self] authResult, error in
            
            self?.delegate?.activateAnimating(activate: false)
            
            
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
                return
            }
            self?.getListFilms()
        }
    }
    
    func getListFilms() {
        goToScreenListFilms()
    }
    
    func goToScreenListFilms() {
        loginCoordinator?.goesToListFilm()
    }
    
    func goToScreenCreateLogin() {
        loginCoordinator?.goesToCreateFilm()
    }
    
    func goToScreenResetLogin() {
        loginCoordinator?.goesToResetFilm()
    }
}

