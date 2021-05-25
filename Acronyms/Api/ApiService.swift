//
//  ApiService.swift
//  Acronyms
//
//  Created by Daniel Velásquez on 24-05-21.
//

import Foundation

typealias LoadHandler = (Result<[Acromine], LoadingError>) -> Void

protocol NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask?
}

extension URLSession: NetworkSession {
    
    @discardableResult
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask? {
        let task = dataTask(with: url) { (data, _, error) in
            completionHandler(data, error)
        }
        task.resume()
        return task
    }
}

class NetworkManager {
    
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    @discardableResult
    func load(_ text: String, then handler: @escaping LoadHandler) -> RequestToken? {
        let urlString = "http://www.nactem.ac.uk/software/acromine/dictionary.py/?sf=" + text
        guard let url = URL(string: urlString) else {
            handler(Result.failure(.wrongUrl))
            return nil
        }
        return RequestToken(task: session.loadData(from: url) { data, error in
            if error != nil {
                handler(Result.failure(.loadFail))
                return
            }
            guard let data = data else {
                handler(Result.failure(.nilData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let loadedType = try decoder.decode([Acromine].self, from: data)
                handler(Result.success(loadedType))
            } catch {
                handler(Result.failure(.decodeFail))
            }
        })
    }
}
