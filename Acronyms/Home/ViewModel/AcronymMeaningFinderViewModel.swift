//
//  AcronymMeaningFinderViewModel.swift
//  Acronyms
//
//  Created by Daniel Velásquez on 24-05-21.
//

import Foundation

class AcronymMeaningFinderViewModel: ViewModel {

    private var meanings = [String]()

    var fetchSuccessHandler: (() -> Void)?
    var fetchErrorHandler: (() -> Void)?

    var networkManager = NetworkManager()
    private var requestToken: RequestToken?

    // MARK:- Networking
    
    func fetch(_ text: String) {
        requestToken?.cancel()
        requestToken = networkManager.load(text) { [weak self] (result: Result<[Acromine], LoadingError>) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let acronyms):
                strongSelf.handle(acronyms)
            case .failure(let error):
                strongSelf.handle(error)
            }
        }
    }

    private func handle(_ acronyms: [Acromine]) {
        if let lfs = acronyms.first?.lfs {
            meanings = lfs.map { $0.lf }
        } else {
            meanings = []
        }
        fetchSuccessHandler?()
    }
    
    private func handle(_ error: LoadingError) {
        meanings = []
        fetchErrorHandler?()
    }

    // MARK: - Public

    func numberOfMeanings() -> Int {
        meanings.count
    }
    
    func meaning(for item: Int) -> String {
        meanings[item]
    }
}
