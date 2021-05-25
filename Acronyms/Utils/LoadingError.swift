//
//  LoadingError.swift
//  Acronyms
//
//  Created by Daniel Velásquez on 24-05-21.
//

import Foundation

enum LoadingError: Error {
    case loadFail
    case nilData
    case decodeFail
    case wrongUrl
}
