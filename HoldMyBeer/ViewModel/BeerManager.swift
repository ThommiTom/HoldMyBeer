//
//  BeerManager.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 12.05.23.
//

import Foundation

class BeerManager: ObservableObject {
    @Published var beers: [Beer] = []

    
    // MARK: - NETWORKING
    func getBeers(url: URL?) {
        Task {
            await NetworkManager.shared.networkCall(with: url) { (result: Result<[Beer], NetworkError>) in
                switch result {
                case .success(let beers):
                    DispatchQueue.main.async {
                        self.beers = beers
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
