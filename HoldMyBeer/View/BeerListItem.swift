//
//  AsyncImageView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

import SwiftUI

struct BeerListItem: View {
    var beer: Beer
    
    var body: some View {
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

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        BeerListItem(beer: .example)
    }
}
