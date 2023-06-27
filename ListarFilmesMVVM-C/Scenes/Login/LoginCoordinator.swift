//
//  LoginCoordinator.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 15/06/23.
//

import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func goesToListFilm(result: [Result])
    func goesToCreateFilm()
    func goesToResetFilm()
}

class LoginCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let viewLoginController = LoginViewController()
        let viewModel = LoginViewModel()
        viewModel.loginCoordinator = self
        viewLoginController.viewModel = viewModel
        return viewLoginController
    }
}

extension LoginCoordinator: LoginCoordinatorDelegate {
    
    func goesToCreateFilm() {
        let createCoordinator = CreateLoginCoordinator()
        let createLoginViewController = createCoordinator.start() as! CreateLoginViewController
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        navigationController.navigationItem.backBarButtonItem = backButton
        navigationController.pushViewController(createLoginViewController, animated: true)
    }
    
    func goesToResetFilm() {
        let resetCoordinator = ResetLoginCoordinator()
        let resetLoginViewController = resetCoordinator.start() as! ResetLoginViewController
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
        navigationController.navigationItem.backBarButtonItem = backButton
        navigationController.pushViewController(resetLoginViewController, animated: true)
    }
    
    func goesToListFilm(result: [Result]) {
        let listCoordinator = FilmListCoordinator(navigationController: self.navigationController)
        let listFilmsViewController = listCoordinator.start() as! FilmListViewController
        listFilmsViewController.filmView.listFilms = result
        let backButton = UIBarButtonItem(title: "Sair do APP", style: .plain, target: nil, action: nil)
        navigationController.navigationItem.backBarButtonItem = backButton
        navigationController.pushViewController(listFilmsViewController, animated: true)
    }
}
