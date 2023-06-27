//
//  FilmDetailViewModel.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit

protocol FilmDetailViewActionsDelegate: AnyObject {
   
}

protocol FilmDetailViewModelDelegate: AnyObject {
    var delegate: FilmDetailViewActionsDelegate? { get set }
}


class FilmDetailViewModel: FilmDetailViewModelDelegate {
    weak var delegate: FilmDetailViewActionsDelegate?
}
