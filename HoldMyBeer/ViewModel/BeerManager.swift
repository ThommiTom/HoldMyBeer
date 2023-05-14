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
}
