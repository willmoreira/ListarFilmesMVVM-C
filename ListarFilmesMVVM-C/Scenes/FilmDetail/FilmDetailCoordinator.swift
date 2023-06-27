//
//  FilmDetailCoordinator.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit

class FilmDetailCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let viewFilmDetailViewController = FilmDetailViewController()
        let viewModel = FilmDetailViewModel()
        viewFilmDetailViewController.viewModel = viewModel
        return viewFilmDetailViewController
    }
}
