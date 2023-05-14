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
                    HStack {
                        Text(malt.name)
                        Spacer()
                        Text("\(malt.amount.value, specifier: "%.1f")")
                        Text(malt.amount.unit)
                    }
                }
            }
            .padding(.bottom, 15)
            
            VStack(alignment: .leading) {
                Text("HOP")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                ForEach(ingridients.hops, id: \.self) { hop in
                    HStack {
                        Text(hop.name)
                        Spacer()
                        Text("\(hop.amount.value, specifier: "%.1f")")
                        Text(hop.amount.unit)
                    }
                }
            }
            .padding(.bottom, 15)
            
            VStack(alignment: .leading) {
                Text("YEAST")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                HStack {
                    Text(ingridients.yeast)
                    Spacer()
                }
            }
            .padding(.bottom, 15)
        }
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView(ingredients: nil)
    }
}
