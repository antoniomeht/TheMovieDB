//
//  Extension+String.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import Foundation

extension String {
    static let empty = ""

    func localize(comment: String = .empty) -> String {
             let defaultLanguage = "es"
             let value = NSLocalizedString(self, comment: comment)
             if value != self || NSLocale.preferredLanguages.first == defaultLanguage {
                 return value
             }

             guard let path = Bundle.main.path(forResource: defaultLanguage, ofType: "lproj"), let bundle = Bundle(path: path) else {
                 return value
             }

        return NSLocalizedString(self, bundle: bundle, comment: .empty)
        }
    
}
