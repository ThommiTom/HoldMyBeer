//
//  RatingView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 15.05.23.
//

import SwiftUI

struct RatingView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var brewManager: BrewManager
    var index: Int
    var beer: Beer
    
    @State private var score: Int = 3
    @State private var comment: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                BeerListItem(beer: beer)
                    .padding(.vertical)
                StarRatingView(rating: $score)
                    .padding(.vertical)
                TextField("comment", text: $comment)
                    .padding(.vertical)
                Spacer()
                Button {
                    brewManager.saveRating(Rating(score: score, comment: comment), for: index)
                    dismiss()
                } label: {
                    Text("Save rating!")
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Rate The Beer")
        }
        
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(brewManager: BrewManager(), index: 0, beer: .example)
    }
}
