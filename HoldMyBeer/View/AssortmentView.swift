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
                                BeerListItem(beer: beer)
                                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                        if !beerManager.addedToBrew.contains(beer.id) {
                                            Button {
                                                beerManager.addToBrews(id: beer.id)
                                                // TODO: Save beer for ToBrew
                                            } label: {
                                                Label("add to\nTo Brews", systemImage: "checklist")
                                            }
                                            .tint(.green)
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
                                BeerListItem(beer: beer)
                                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                        if !beerManager.addedToBrew.contains(beer.id) {
                                            Button {
                                                beerManager.addToBrews(id: beer.id)
                                                // TODO: Save beer for ToBrew
                                            } label: {
                                                Label("add to\nTo Brews", systemImage: "checklist")
                                            }
                                            .tint(.green)
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
                    Image(systemName: "arrow.up.arrow.down")
                        .foregroundColor(.blue)
                        .contextMenu {
                            ForEach(BeerSorting.allCases) { sortCase in
                                Button(sortCase.rawValue) {
                                    self.beerManager.sorting = sortCase
                                }
                            }
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
