//
//  BeerDetailList.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import SwiftUI

struct BeerDetailView: View {
    let beer: Beer
    @State var showInBrewsLabel: Bool = false
    var saveBeerToBrews: ((Beer) -> Void)?
    var loadBeers: (() -> Void)?
    var inBrews: (() -> Bool)?

    var body: some View {
        VStack {
            BeerListItem(beer: beer, containedInToBrew: showInBrewsLabel, width: 75, height: 150)

            ScrollView {
                description
                IngredientsView(ingredients: beer.ingredients)
                foodPairing
            }
        }
        .navigationTitle("Take a closer look")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                addBeerButton
            }
        }
        .onAppear {
            if loadBeers != nil && inBrews != nil {
                loadBeers!()
                showInBrewsLabel =  inBrews!()
            }
        }
        .padding()
    }
}

struct BeerDetailList_Previews: PreviewProvider {
    static var previews: some View {
        BeerDetailView(beer: .example, showInBrewsLabel: true)
    }
}

extension BeerDetailView {
    var description: some View {
        Group {
            Text("Description")
                .font(.caption)
                .foregroundColor(.secondary)
            Divider()
            Text(beer.description)
                .padding(.bottom, 30)
        }
    }

    var foodPairing: some View {
        Group {
            if !beer.foodPairing.isEmpty {
                Text("Food pairing")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Divider()
                VStack(alignment: .leading) {
                    ForEach(beer.foodPairing, id: \.self) {
                        Text($0)
                            .padding(.all, 3)
                    }
                }
            }
        }
    }

    var addBeerButton: some View {
        Group {
            if saveBeerToBrews != nil {
                Button {
                    showInBrewsLabel = true
                    saveBeerToBrews!(beer)
                } label: {
                    Text("Add 🍺 to Brews")
                }
                .disabled(showInBrewsLabel)
            }
        }
    }
}
