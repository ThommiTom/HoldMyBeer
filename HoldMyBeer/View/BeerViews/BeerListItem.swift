//
//  BeerListItem.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 13.05.23.
//

import SwiftUI

struct BeerListItem: View {
    let beer: Beer

    var containedInToBrew: Bool = false
    var width: CGFloat = 50
    var height: CGFloat = 100

    var body: some View {
        HStack(spacing: 15) {
            beerImage

            VStack(alignment: .leading, spacing: 10) {
                beerInfo
                beerAttributes
            }
        }
    }
}

struct BeerListItem_Previews: PreviewProvider {
    static var previews: some View {
        BeerListItem(beer: .example, containedInToBrew: true)
    }
}

extension BeerListItem {
    var beerImage: some View {
        Group {
            if let imageURL = beer.imageUrl {
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
        }
    }

    var beerInfo: some View {
        Group {
            HStack {
                Text("🍺 added to Brews")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .opacity(containedInToBrew ? 1 : 0)
                Spacer()
                if let firstBrewed = beer.firstBrewed {
                    Text("first brewed \(firstBrewed)")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
            }

            Text(beer.name)
                .font(.title3)
                .bold()
            Text(beer.tagline)
                .font(.callout)
        }
    }

    var beerAttributes: some View {
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
