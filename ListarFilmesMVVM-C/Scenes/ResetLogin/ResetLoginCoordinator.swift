//
//  ResetLoginCoordinator.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit

protocol ResetLoginCoordinatorDelegate: AnyObject {
    func goesToListFilm()
}

class ResetLoginCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let viewLoginController = ResetLoginViewController()
        let viewModel = ResetLoginViewModel()
        viewModel.resetLoginCoordinator = self
        viewLoginController.viewModel = viewModel
        return viewLoginController
    }
}

extension ResetLoginCoordinator: ResetLoginCoordinatorDelegate {
    func goesToListFilm() {
        let listFilmsViewController = FilmListViewController()
        let backButton = UIBarButtonItem(title: "Sair do APP", style: .plain, target: nil, action: nil)
        navigationController.navigationItem.backBarButtonItem = backButton
        navigationController.pushViewController(listFilmsViewController, animated: true)
    }
}
