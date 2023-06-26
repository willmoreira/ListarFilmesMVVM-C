//
//  LoginViewController.swift
//  ListarFilmesMVVM-C
//
//  Created by William Moreira on 06/06/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, LoginViewDelegate {
    
    var loginView = LoginView()
    var listFilms: [Result] = []
    var login: String = ""
    var senha: String = ""
    var viewModel: LoginViewModelDelegate?
    
    override func loadView() {
        super.loadView()
        view = loginView
        loginView.delegate = self
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activateAnimating(activate: false)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cleanTextFields()
    }
    
    func getData() {
        guard let username = loginView.inputLogin.text, !username.isEmpty else {
            showAlert(title: ProjectStrings.errorInLoginField.localized,
                      message: ProjectStrings.errorInLoginFieldMessage.localized)
            activateAnimating(activate: false)
            return
        }
        guard let password = loginView.inputSenha.text, !password.isEmpty else {
            showAlert(title: ProjectStrings.errorInPasswordField.localized,
                      message: ProjectStrings.errorInPasswordFieldMessage.localized)
            activateAnimating(activate: false)
            return
        }
        viewModel?.tryLogin(login: username, senha: password)
    }
   
    func dismissKeyboard() {
        if loginView.inputLogin.isFirstResponder || loginView.inputSenha.isFirstResponder {
            view.endEditing(true)
        }
    }
    
    func loginButtonPressed() {
        activateAnimating(activate: true)
        getData()
    }
    
    func resetButtonPressed() {
        viewModel?.goToScreenResetLogin()
    }
    
    func createButtonPressed() {
        viewModel?.goToScreenCreateLogin()
    }
    
    @objc func exitButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension LoginViewController: LoginViewActionsDelegate {
    
    func cleanTextFields() {
        DispatchQueue.main.async {
            self.loginView.inputLogin.becomeFirstResponder()
            self.loginView.inputLogin.text = ProjectStrings.stringEmpty.localized
            self.loginView.inputSenha.text = ProjectStrings.stringEmpty.localized
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func activateAnimating(activate: Bool) {
        DispatchQueue.main.async {
            if activate {
                self.loginView.activityIndicator.startAnimating()
            } else {
                self.loginView.activityIndicator.stopAnimating()
            }
        }
    }
}
