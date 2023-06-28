//
//  CreateLoginCoordinator.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit

class CreateLoginCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let viewLoginController = CreateLoginViewController()
        let viewModel = CreateLoginViewModel()
        viewLoginController.viewModel = viewModel
        return viewLoginController
    }
}
