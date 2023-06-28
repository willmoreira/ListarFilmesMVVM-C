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
    let createLoginService = CreateLoginService()

    func tryCreateLogin(login: String, password: String) {
        createLoginService.createUser(withEmail: login, password: password) { _, error in
            self.delegate?.activateAnimating(activate: true)
            if let error = error as NSError? {
                if error.code == 17007 {
                    self.delegate?.showAlert(title: ProjectStrings.emailAlreadyInUse.localized,
                                             message: ProjectStrings.emailAlreadyInUseMessage.localized,
                                             result: false)
                }
                if error.code == 17008 {
                    self.delegate?.showAlert(title: ProjectStrings.incorrectEmailFormat.localized,
                                             message: ProjectStrings.incorrectEmailFormatMessage.localized,
                                             result: false)
                }
                if error.code == 17026 {
                    self.delegate?.showAlert(title: ProjectStrings.passwordRule.localized,
                                             message: ProjectStrings.passwordRuleMessage.localized,
                                             result: false)
                }
                self.delegate?.activateAnimating(activate: false)
                return
            }
            self.delegate?.showAlert(title: ProjectStrings.success.localized,
                               message: ProjectStrings.userSuccessfullyCreatedMessage.localized,
                               result: true)
        }
    }
}
