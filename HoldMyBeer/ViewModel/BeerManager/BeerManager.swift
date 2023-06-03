//
//  BeerManager.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 12.05.23.
//

// import Combine
import SwiftUI
import Foundation

class BeerManager: ObservableObject {
    @Published private(set) var beerCatalog: [Beer] = []
    @Published private(set) var searchedBeers: [Beer] = []

    @Published var alertData = AlertData()
    @Published var isShowMoreButtonActive = true

    @Published private(set) var beersToBrew = [Int]()

    @Published var sorting: BeerSorting = .none

    @Published var navigationPath = NavigationPath()

    init() {
        self.getBeers()
    }

    private(set) var viewTitle: String = ""

    private(set) var pageNo = 1
    let itemsPerPage = 50

//    var cancellables = Set<AnyCancellable>()

    func appendCatalog(with beers: [Beer]) {
        beerCatalog.append(contentsOf: beers)
    }

    func processSearched(new beers: [Beer]) {
        if beers.isEmpty {
            setAlert()
            resetSearchResult()
        } else {
            setSearched(beers)
        }
    }

    private func setSearched(_ beers: [Beer]) {
        DispatchQueue.main.async {
            self.searchedBeers = beers
        }
    }

    func resetSearchResult() {
        DispatchQueue.main.async {
            self.searchedBeers.removeAll()
        }
    }

    func incrementPageNo() {
        pageNo += 1
    }

    func addToBrews(id: Int) {
        if !beersToBrew.contains(id) {
            beersToBrew.append(id)
        }
    }

    func containedInBrews(id: Int) -> Bool {
        beersToBrew.contains(id)
    }

    func saveBeerToBrews(_ beer: Beer) {
        Persistence.shared.saveBeerToBrew(beer)
    }

    func loadBeersToBrew() {
        let loaded = Persistence.shared.loadBeersToBrew()

        beersToBrew.removeAll()
        for item in loaded {
            beersToBrew.append(item.id)
        }
    }

    func resetPath() {
        navigationPath = NavigationPath()
    }
}
