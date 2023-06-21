//
//  String+Extension.swift
//  ListarFilmesMVVM-C
//
//  Created by William on 19/06/23.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String{
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
    }
}
