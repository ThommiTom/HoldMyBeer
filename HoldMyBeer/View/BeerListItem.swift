//
//  AsyncImageView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

import SwiftUI

struct BeerListItem: View {
    var beer: Beer
    var containedInToBrew: Bool = false
    var width: CGFloat = 50
    var height: CGFloat = 100
    
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
                .frame(width: width, height: height, alignment: .center)
            } else {
                Text("🍻")
                    .font(.largeTitle)
                    .frame(width: width, height: height, alignment: .center)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("contained in To Brew 🍺")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .opacity(containedInToBrew ? 1 : 0)
                Text(beer.name)
                    .font(.title3)
                    .bold()
                Text(beer.tagline)
                    .font(.callout)
                
                HStack {
                    if let ebc = beer.ebc {
                        Text("Color")
                            .foregroundColor(.secondary)
                            .font(.caption)
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(.secondary, lineWidth: 1)
                            .background(RoundedRectangle(cornerRadius: 5).fill(EBCScale.getColor(by: ebc)))
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    Spacer()
                    Text("alc \(beer.abv, specifier: "%.1f") % vol.")
                        .foregroundColor(.secondary)
                        .font(.caption)
                    Spacer()
                    if let ibu = beer.ibu {
                        Text("Bitterness \(ibu, specifier: "%.0f")/120")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
            }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        BeerListItem(beer: .example, containedInToBrew: true)
    }
}
