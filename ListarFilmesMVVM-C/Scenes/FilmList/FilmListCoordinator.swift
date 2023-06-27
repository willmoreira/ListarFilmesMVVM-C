//
//  FilmListCoordinator.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit


protocol FilmListCoordinatorDelegate: AnyObject {
    func goesToDetailFilm(result: Result)
}

class FilmListCoordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() -> UIViewController {
        let viewFilmListViewController = FilmListViewController()
        let viewModel = FilmListViewModel()
        viewModel.filmListCoordinator = self
        viewFilmListViewController.viewModel = viewModel
        return viewFilmListViewController
    }
}

extension FilmListCoordinator: FilmListCoordinatorDelegate {
    func goesToDetailFilm(result: Result) {
        let detailCoordinator = FilmDetailCoordinator()
        let filmDetailViewController = detailCoordinator.start() as! FilmDetailViewController
        filmDetailViewController.mainView.film = result
        let backButton = UIBarButtonItem(title: "Sair do APP", style: .plain, target: nil, action: nil)
        self.navigationController.navigationItem.backBarButtonItem = backButton
        self.navigationController.pushViewController(filmDetailViewController, animated: true)
    }
}
