//
//  BeerManager+NetworkCalls.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

// import Combine
import Foundation

extension BeerManager {
    func searchBeers() {
        Task {
            let url = URLBuilder.shared.buildURL()
            await NetworkManager.shared.networkCall(with: url) { (result: Result<[Beer], NetworkError>) in
                switch result {
                case .success(let beers):
                    self.processSearched(new: beers)
                case .failure(let error):
                    self.setErrorAlert(with: error)
                }
            }
        }
    }

    func getBeers() {
        Task {
            let url = URLBuilder.shared.createPaginationURL(page: pageNo, itemsPerPage: itemsPerPage)
            await NetworkManager.shared.networkCall(with: url) { (result: Result<[Beer], NetworkError>) in
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
                    self.setErrorAlert(with: error)
                }
            }
        }
    }
}

/* Network calls with combine */

// extension BeerManager {
//    func searchBeersOverCombine() {
//        guard let url = URLBuilder.shared.buildURL() else { return }
//
//        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background))
//            .receive(on: DispatchQueue.main)
//            .tryMap { (data, response) -> Data in
//                guard let response = response as? HTTPURLResponse,
//                        (200...299).contains(response.statusCode) else { throw URLError(.badURL)}
//                return data
//            }
//            .decode(type: [Beer].self, decoder: JSONDecoder())
//            .sink { (completion) in
//                switch completion {
//                case .finished:
//                    print("finished completion")
//                case .failure(let error):
//                    if let networkError = error as? NetworkError {
//                        self.setErrorAlert(with: networkError)
//                    }
//
//                    print(error.localizedDescription)
//                }
//            } receiveValue: { [weak self] beers in
//                self?.processSearched(new: beers)
//            }
//            .store(in: &cancellables)
//    }
// }
