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
}


class FilmListViewModel: FilmListViewModelDelegate {
    weak var delegate: FilmListViewActionsDelegate?
}
