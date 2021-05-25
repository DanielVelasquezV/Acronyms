//
//  NetworkSessionMock.swift
//  AcronymsTests
//
//  Created by Daniel Velásquez on 25-05-21.
//

import Foundation

class NetworkSessionMock: NetworkSession {
    
    var data: Data?
    var error: Error?

    @discardableResult
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask? {
        completionHandler(data, error)
        return nil
    }
}
