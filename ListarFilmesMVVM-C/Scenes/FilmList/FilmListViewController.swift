//
//  ListFilmsViewController.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit

class FilmListViewController: UIViewController, FilmListViewDelegate {
   
    var filmView = FilmListView()
    var films: [Result] = []
    var viewModel: FilmListViewModelDelegate?

    override func loadView() {
        super.loadView()
        view = filmView
        view.backgroundColor = .white
        filmView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
    }
//
//    func goToDetailViewController(filmSelected: Result) {
//        let detailVC = DetailFilmViewController()
//        detailVC.film = filmSelected
//        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backButton
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
   
}

extension FilmListViewController: FilmListViewActionsDelegate {
    func goToDetailViewController(_ index: Int) {
        
    }
}
