//
//  IngridientsView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import SwiftUI

struct IngredientsView: View {
    let ingredients: Ingredients?

    var body: some View {
        if let ingridients = ingredients {
            Text("Ingriedients")
                .font(.caption)
                .foregroundColor(.secondary)
            Divider()

            VStack(alignment: .leading) {
                Text("MALT")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                ForEach(ingridients.malt, id: \.self) { malt in
                    if let value = malt.amount.value {
                        HStack {
                            Text(malt.name)
                            Spacer()
                            Text("\(value.decimalSpecifier(1))")
                            Text(malt.amount.unit)
                        }
                    }
                }
            }
            .padding(.bottom, 15)

            VStack(alignment: .leading) {
                Text("HOP")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                ForEach(ingridients.hops, id: \.self) { hop in
                    if let value = hop.amount.value {
                        HStack {
                            Text(hop.name)
                            Spacer()
                            Text("\(value.decimalSpecifier(1))")
                            Text(hop.amount.unit)
                        }
                    }
                }
            }
            .padding(.bottom, 15)

            if let yeast = ingridients.yeast {
                VStack(alignment: .leading) {
                    Text("YEAST")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    HStack {
                        Text(yeast)
                        Spacer()
                    }
                }
                .padding(.bottom, 15)
            }
        }
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView(ingredients: nil)
    }
}
