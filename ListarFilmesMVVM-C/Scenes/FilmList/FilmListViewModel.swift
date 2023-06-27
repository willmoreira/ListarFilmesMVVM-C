//
//  FilmListViewModel.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit

protocol FilmListViewActionsDelegate: AnyObject {
   
}

protocol FilmListViewModelDelegate: AnyObject {
    var delegate: FilmListViewActionsDelegate? { get set }
    func goesToDetailFilm(result: Result) 
}


class FilmListViewModel: FilmListViewModelDelegate {
    
    weak var delegate: FilmListViewActionsDelegate?
    var filmListCoordinator: FilmListCoordinatorDelegate?
    
    func goesToDetailFilm(result: Result) {
        filmListCoordinator?.goesToDetailFilm(result: result)
    }
}
