//
//  BeerSearchView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

import SwiftUI

struct AssortmentView: View {
    @ObservedObject var beerManager: BeerManager
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack {
            Group {
                if beerManager.searchedBeers.isEmpty {
                    List {
                        ForEach(beerManager.sortedBeers) { beer in
                            NavigationLink(value: beer) {
                                BeerListItem(beer: beer, containedInToBrew: beerManager.containedInToBrew(id: beer.id))
                                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                        if !beerManager.addedToBrew.contains(beer.id) {
                                            Button {
                                                beerManager.addToBrews(id: beer.id)
                                                beerManager.saveBeerToBrews(beer)
                                            } label: {
                                                Label("add to\n\'To Brews\'", systemImage: "checklist")
                                            }
                                            .tint(.blue)
                                        }
                                    }
                            }
                        }
                        
                        ShowMoreButton(showButton: $beerManager.isShowMoreButtonActive) {
                            beerManager.getBeers()
                        }
                    }
                } else {
                    List {
                        ForEach(beerManager.sortedSearchedBeers) { beer in
                            NavigationLink(value: beer) {
                                BeerListItem(beer: beer, containedInToBrew: beerManager.containedInToBrew(id: beer.id))
                                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                        if !beerManager.addedToBrew.contains(beer.id) {
                                            Button {
                                                beerManager.addToBrews(id: beer.id)
                                                beerManager.saveBeerToBrews(beer)
                                            } label: {
                                                Label("add to\n\'To Brews\'", systemImage: "checklist")
                                            }
                                            .tint(.blue)
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(beerManager.searchedBeers.isEmpty ? "Beer Assortment" : "Search Result")
            .navigationDestination(for: Beer.self) { beer in
                BeerDetailView(beer: beer)
            }
            .toolbar {
                if !beerManager.searchedBeers.isEmpty {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            beerManager.resetSearchResult()
                        } label: {
                            Image(systemName: "xmark.circle")
                        }
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(BeerSorting.allCases) { sortCase in
                            Button(sortCase.rawValue) {
                                self.beerManager.sorting = sortCase
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }

                    Button {
                        showSheet = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                SearchView {
                    beerManager.searchBeers()
                }
            }
            .onAppear {
                beerManager.loadBeersToBrew()
            }
            .alert(beerManager.alertData.title, isPresented: $beerManager.alertData.show) {
                Button("OK") {}
            } message: {
                VStack {
                    Text(beerManager.alertData.message)
                }
            }
        }
    }
}

struct AssortmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssortmentView(beerManager: BeerManager())
    }
}
