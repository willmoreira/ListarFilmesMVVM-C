//
//  ResetLoginViewController.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit
import FirebaseAuth

class ResetLoginViewController: UIViewController, ResetLoginViewDelegate {
    
    var resetLoginView = ResetLoginView()
    var viewModel: ResetViewModelDelegate?

    override func loadView() {
        super.loadView()
        view = resetLoginView
        resetLoginView.delegate = self
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
    }
    
    func resetLoginButtonPressed() {
        getData()
    }
    
    func getData() {
        let email = resetLoginView.inputLogin.text!
        if !email.isEmpty {
            viewModel?.tryReset(login: email)
        } else {
            showAlert(title: ProjectStrings.errorInLoginField.localized,
                      message: ProjectStrings.errorInLoginFieldMessage.localized, result: false)
        }
    }
}

extension ResetLoginViewController: ResetLoginViewActionsDelegate {
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
            resetLoginView.activityIndicator.startAnimating()
        } else {
            resetLoginView.activityIndicator.stopAnimating()
        }
    }
}
