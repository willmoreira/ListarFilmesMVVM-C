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
    func signIn(withEmail email: String, password: String)
    func goToScreenCreateLogin()
    func goToScreenResetLogin()
}

class LoginViewModel: LoginViewModelDelegate {
    
    weak var delegate: LoginViewActionsDelegate?
    var loginCoordinator: LoginCoordinatorDelegate?
    let loginService = LoginService()
    
    func signIn(withEmail email: String, password: String) {
        loginService.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error as NSError? {
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
        loginService.doRequestListFilms { results in
            self.goToScreenListFilms(filmList: results)
        }
    }
    
    func goToScreenListFilms(filmList: [Result]) {
        loginCoordinator?.goesToListFilm(result: filmList)
    }
    
    func goToScreenCreateLogin() {
        loginCoordinator?.goesToCreateFilm()
    }
    
    func goToScreenResetLogin() {
        loginCoordinator?.goesToResetFilm()
    }
}

