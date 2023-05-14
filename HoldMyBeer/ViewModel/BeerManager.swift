//
//  BeerManager.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 12.05.23.
//

import Foundation

class BeerManager: ObservableObject {
    @Published private(set) var beerCatalog: [Beer] = []
    @Published private(set) var searchedBeers: [Beer] = []

    @Published var alertData = AlertData()
    @Published var isShowMoreButtonActive = true
    
    @Published private(set) var addedToBrew = [Int]()
    
    @Published var sorting: BeerSorting = .none
    
    init() {
        self.getBeers()
    }
    
    private(set) var viewTitle: String = ""
    
    private(set) var pageNo = 1
    let itemsPerPage = 50
    
    func appendCatalog(with beers: [Beer]) {
        beerCatalog.append(contentsOf: beers)
    }
    
    func process(new beers: [Beer]) {
        if beers.isEmpty {
            setAlert()
            resetSearchResult()
        } else {
            setSearched(beers)
        }
    }
    
    private func setAlert() {
        DispatchQueue.main.async {
            self.alertData.title = "Oops..."
            self.alertData.message = "Sorry, we couldn't find what you're looking for... 😕"
            self.alertData.show = true
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
        if !addedToBrew.contains(id) {
            addedToBrew.append(id)
        }
    }
    
    func containedInToBrew(id: Int) -> Bool {
        addedToBrew.contains(id)
    }
    
    func saveBeerToBrews(_ beer: Beer) {
        Persistence.shared.saveBeersToBrew(beer)
    }
    
    func loadBeersToBrew() {
        let loaded = Persistence.shared.loadBeersToBrew()
        
        addedToBrew.removeAll()
        for item in loaded {
            addedToBrew.append(item.id)
        }
    }
}
