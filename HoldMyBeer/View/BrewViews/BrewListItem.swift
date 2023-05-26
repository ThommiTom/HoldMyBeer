//
//  BrewListItem.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 15.05.23.
//

import SwiftUI

struct BrewListItem: View {
    var brew: Brew

    var body: some View {
        VStack {
            BeerListItem(beer: brew.beer)

            HStack {
                ProgressView("Brew Progress", value: brew.progress, total: 100.0)
                    .tint(brew.beer.ebc != nil ? EBCScale.getColor(by: brew.beer.ebc!) : .blue)
                    .padding()
                Spacer()
                Text("\(brew.progress, specifier: "%.1f")%")
            }
        }
    }
}

struct BrewListItem_Previews: PreviewProvider {
    static var previews: some View {
        BrewListItem(brew: .example)
    }
}
