//
//  FilmListCoordinator.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit


class FilmListCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let viewFilmListViewController = FilmListViewController()
        let viewModel = FilmListViewModel()
        viewFilmListViewController.viewModel = viewModel
        return viewFilmListViewController
    }
}
