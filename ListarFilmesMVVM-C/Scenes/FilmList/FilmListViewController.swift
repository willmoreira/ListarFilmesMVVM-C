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

    func goToDetailViewController(_ index: Int) {
        viewModel?.goesToDetailFilm(result: filmView.listFilms[index])
    }
}

extension FilmListViewController: FilmListViewActionsDelegate {
    func goToDetailViewController(_ index: Int, filmSelected: Result) {
        
    }
}
