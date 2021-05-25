//
//  RequestToken.swift
//  Acronyms
//
//  Created by Daniel Velásquez on 24-05-21.
//

import Foundation

/// URLSessionDataTask wrapper. Useful to cancel a task whenever we want to start a new one.
class RequestToken {
    
    private weak var task: URLSessionDataTask?
    
    init(task: URLSessionDataTask?) {
        self.task = task
    }
    
    func cancel() {
        task?.cancel()
    }
}
