//
//  BeerCatalogView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

import SwiftUI

struct BeerCatalogView: View {
    @StateObject var beerManager = BeerManager()

    @State private var showSheet = false

    var body: some View {
        NavigationStack(path: $beerManager.navigationPath) {
            swipeActionIndicator

            Group {
                if beerManager.searchedBeers.isEmpty {
                    List {
                        BeerListContent(beerManager: beerManager, beers: beerManager.sortedBeers)
                        ShowMoreButton(showButton: $beerManager.isShowMoreButtonActive, getBeers: beerManager.getBeers)
                    }
                } else {
                    List {
                        BeerListContent(beerManager: beerManager, beers: beerManager.sortedSearchedBeers)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(beerManager.searchedBeers.isEmpty ? "Beer Catalog" : "Search Result")
            .navigationDestination(for: Beer.self) { beer in
                BeerDetailView(beer: beer) { beer in
                    beerManager.saveBeerToBrews(beer)
                } loadBeers: {
                    beerManager.loadBeersToBrew()
                } inBrews: {
                    beerManager.containedInBrews(id: beer.id)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    deleteButton
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    sortingMenu
                }
            }
            .sheet(isPresented: $showSheet) {
                SearchView(searchBeers: beerManager.searchBeers)
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

struct BeerCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        BeerCatalogView()
    }
}

extension BeerCatalogView {
    var swipeActionIndicator: some View {
        HStack(spacing: 20) {
            Image(systemName: "arrow.right")
            Text("Swipe right to add beer to Brews")
            Image(systemName: "arrow.right")
        }
        .font(.caption)
        .bold()
        .foregroundColor(.blue)
    }

    var deleteButton: some View {
        Group {
            if !beerManager.searchedBeers.isEmpty {
                Button {
                    beerManager.resetSearchResult()
                } label: {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.red)
                }
            }
        }
    }

    var sortingMenu: some View {
        Group {
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
}
