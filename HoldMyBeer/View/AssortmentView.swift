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
                        ForEach(beerManager.beerCatalog) {
                            BeerListItem(beer: $0)
                        }
                        
                        ShowMoreButton(showButton: $beerManager.isShowMoreButtonActive) {
                            beerManager.getBeers()
                        }
                    }
                } else {
                    List {
                        ForEach(beerManager.searchedBeers) {
                            BeerListItem(beer: $0)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(beerManager.searchedBeers.isEmpty ? "Beer Assortment" : "Search Result")
            .toolbar {
                if !beerManager.searchedBeers.isEmpty {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            beerManager.resetSearchResult()
                        } label: {
                            Image(systemName: "xmark.circle")
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
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
            .onAppear {
                beerManager.getBeers()
            }
        }
    }
}

struct AssortmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssortmentView(beerManager: BeerManager())
    }
}
