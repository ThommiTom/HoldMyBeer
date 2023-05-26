//
//  BeerDetailList.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import SwiftUI

struct BeerDetailView: View {
    var beer: Beer
    var containedInToBrew: Bool = false

    var body: some View {
        VStack {
            BeerListItem(beer: beer, containedInToBrew: containedInToBrew, width: 75, height: 150)

            ScrollView {
                Text("Description")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Divider()
                Text(beer.description)
                    .padding(.bottom, 30)

                IngredientsView(ingredients: beer.ingredients)

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
        .navigationTitle("Take a closer look")
        .padding()
    }
}

struct BeerDetailList_Previews: PreviewProvider {
    static var previews: some View {
        BeerDetailView(beer: .example, containedInToBrew: true)
    }
}
