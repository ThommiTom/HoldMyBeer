//
//  BeerManager.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 12.05.23.
//

import Foundation

class BeerManager: ObservableObject {
    @Published var beers: [Beer] = []
    
    func getBeers(request: URLRequest) {
        Task {
            await NetworkManager.shared.networkCall(with: request) { (result: Result<[Beer], NetworkError>) in
                switch result {
                case .success(let beers):
                    DispatchQueue.main.async {
                        self.beers.append(contentsOf: beers)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
