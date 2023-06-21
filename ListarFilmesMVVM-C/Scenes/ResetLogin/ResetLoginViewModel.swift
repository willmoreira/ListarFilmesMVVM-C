//
//  ResetLoginViewModel.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit
import FirebaseAuth

protocol ResetLoginViewActionsDelegate: AnyObject {
    func activateAnimating(activate: Bool)
    func showAlert(title: String, message: String)
}

protocol ResetViewModelDelegate: AnyObject {
    var delegate: ResetLoginViewActionsDelegate? { get set }
    func tryReset(login: String)
}

class ResetLoginViewModel: ResetViewModelDelegate {
    
    weak var delegate: ResetLoginViewActionsDelegate?
    var resetLoginCoordinator: ResetLoginCoordinatorDelegate?
    var resetLoginService: ResetLoginService?
   
    func tryReset(login: String) {
        
        self.delegate?.activateAnimating(activate: true)
        
        Auth.auth().sendPasswordReset(withEmail: login) { error in
            
            self.delegate?.activateAnimating(activate: false)
            
            if let error = error as? NSError{
                if error.code == 17011 {
                    self.delegate?.showAlert(title: ProjectStrings.userNotFound.localized,
                              message: ProjectStrings.userNotFoundMessage2.localized)
                    
                }
                return
            }
            self.goToScreenListFilms()
        }
    }
    
    func goToScreenListFilms() {
        resetLoginCoordinator?.goesToListFilm()
    }

}




