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
    @State private var showingPopover = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(beerManager.beers) { beer in
                    HStack(spacing: 15) {
                        if let imageURL = beer.image_url {
                            AsyncImage(url: URL(string: imageURL)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 100, alignment: .center)
                        } else {
                            Text("🍻")
                                .font(.largeTitle)
                                .frame(width: 50, height: 100, alignment: .center)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(beer.name)
                                .font(.title3)
                                .bold()
                            Text(beer.tagline)
                                .font(.callout)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSheet = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .navigationTitle("Beer Assortment")
        }
        .sheet(isPresented: $showSheet) {
            BeerSearch(beerManager: beerManager)
        }
    }
}

struct AssortmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssortmentView(beerManager: BeerManager())
    }
}
