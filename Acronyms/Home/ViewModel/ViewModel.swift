//
//  ViewModel.swift
//  Acronyms
//
//  Created by Daniel Velásquez on 24-05-21.
//

import Foundation

protocol ViewModel {
    func fetch(_ text: String)
    var fetchSuccessHandler: (() -> Void)? { get set }
    var fetchErrorHandler: (() -> Void)? { get set }
    func numberOfMeanings() -> Int
    func meaning(for item: Int) -> String
}
