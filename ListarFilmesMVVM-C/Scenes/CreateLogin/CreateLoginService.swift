//
//  CreateLoginService.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import UIKit
import FirebaseAuth

class CreateLoginService {
    
    func createUser(withEmail: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: withEmail, password: password) { result, error in
            completion?(result, error)
        }
    }
}
