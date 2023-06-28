//
//  FilmDetailViewController.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit

class FilmDetailViewController: UIViewController, FilmDetailViewDelegate {
    
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
