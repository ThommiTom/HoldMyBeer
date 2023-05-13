//
//  BeerManager+NetworkCalls.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

import Foundation

extension BeerManager {
    func searchBeers(url: URL?) {
        Task {
            await NetworkManager.shared.networkCall(with: url) { (result: Result<[Beer], NetworkError>) in
                switch result {
                case .success(let beers):
                    DispatchQueue.main.async {
                        self.setSearched(beers)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getBeers() {
        Task {
            await NetworkManager.shared.networkCall(with: URLBuilder.shared.createPaginationURL(page: pageNo, itemsPerPage: itemsPerPage)) { (result: Result<[Beer], NetworkError>) in
                switch result {
                case .success(let newBeers):
                    if !newBeers.isEmpty {
                        self.incrementPageNo()
                        DispatchQueue.main.async {
                            self.appendCatalog(with: newBeers)
                            
                            if newBeers.count < self.itemsPerPage {
                                self.isShowMoreButtonActive = false
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.isShowMoreButtonActive = false
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
