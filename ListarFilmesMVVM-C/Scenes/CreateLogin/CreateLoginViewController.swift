//
//  CreateLoginViewController.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit
import FirebaseAuth

class CreateLoginViewController: UIViewController, CreateLoginViewDelegate {
    
    var createLoginView = CreateLoginView()
    var viewModel: CreateLoginViewModelDelegate?
    
    override func loadView() {
        super.loadView()
        view = createLoginView
        view.backgroundColor = .white
        createLoginView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
    }
    
    func createButtonPressed() {
        getData()
    }
    
    func getData() {
        let senha = createLoginView.inputSenha.text!
        let login = createLoginView.inputLogin.text!
        
        if !login.isEmpty {
            if !senha.isEmpty {
                activateAnimating(activate: true)
                viewModel?.tryCreateLogin(login: login, password: senha)
            } else {
                showAlert(title: ProjectStrings.errorInPasswordField.localized,
                          message: ProjectStrings.errorInPasswordFieldMessage.localized,
                          result: false)
            }
        } else {
            showAlert(title: ProjectStrings.errorInLoginField.localized,
                      message: ProjectStrings.errorInLoginFieldMessage.localized,
                      result: false)
        }
    }
}

extension CreateLoginViewController: CreateLoginViewActionsDelegate {
    func showAlert(title: String, message: String, result: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: ProjectStrings.ok.localized, style: .default) { _ in
            if result {
                self.navigationController?.popViewController(animated: true)
            }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func activateAnimating(activate: Bool) {
        if activate {
            createLoginView.activityIndicator.startAnimating()
        } else {
            createLoginView.activityIndicator.stopAnimating()
        }
    }
}
