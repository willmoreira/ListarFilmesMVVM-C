//
//  ResetLoginCoordinator.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit

class ResetLoginCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let viewLoginController = ResetLoginViewController()
        let viewModel = ResetLoginViewModel()
        viewLoginController.viewModel = viewModel
        return viewLoginController
    }
}
