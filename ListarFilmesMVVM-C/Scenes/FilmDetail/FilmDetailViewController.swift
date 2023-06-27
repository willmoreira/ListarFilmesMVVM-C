//
//  FilmDetailViewController.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit

class FilmDetailViewController: UIViewController, FilmDetailViewDelegate {
    
    var film = Result(
        adult: false,
        backdropPath: "",
        genreIDS: [0],
        id: 0,
        originalLanguage: "",
        originalTitle: "",
        overview: "",
        popularity: 0.0,
        posterPath: "",
        releaseDate: "",
        title: "",
        video: false,
        voteAverage: 0.0,
        voteCount: 0)
    
    var mainView = FilmDetailView()
    var viewModel: FilmDetailViewModelDelegate?
    
    override func loadView() {
        super.loadView()
        view = mainView
        mainView.delegate = self
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
