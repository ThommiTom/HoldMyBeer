//
//  SommerierView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import SwiftUI

struct SommelierView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var searchParameter: SearchParameter
    var searchBeers: () -> Void
    
    var body: some View {
        VStack {
            Text("Tell us what you're eatin'")
                .font(.title2)
            Text("and we tell you what to drink!")
                .font(.title2)
            Text("🍔🍺\t🌯🍺\t🍕🍺")
                .font(.title)
                .padding()
            
            
            TextField("food, dish, snack, ...", text: $searchParameter.foodPairing)
                .onChange(of: searchParameter.foodPairing, perform: { newValue in
                    let _ = URLBuilder.shared.addFuzzyQueryItem(for: .food, newValue)
                })
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            Button {
                searchBeers()
                dismiss()
                searchParameter = SearchParameter()
            } label: {
                Text("Recommend something!")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear {
            URLBuilder.shared.resetQueryItems()
        }
    }
}

struct SommelierView_Previews: PreviewProvider {
    static var previews: some View {
        SommelierView(searchParameter: Binding<SearchParameter>.constant(SearchParameter())) {
            print("search beers network call here")
        }
    }
}
