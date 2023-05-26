//
//  ShowMoreButton.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import SwiftUI

struct ShowMoreButton: View {
    @Binding var showButton: Bool
    var getBeers: () -> Void

    var body: some View {
        if showButton {
            HStack(alignment: .center) {
                Spacer()
                Button {
                    getBeers()
                } label: {
                    Text("show more")
                        .font(.caption)
                }
                Spacer()
            }
        }
    }
}

struct ShowMoreButton_Previews: PreviewProvider {
    static var previews: some View {
        ShowMoreButton(showButton: Binding<Bool>.constant(true)) {
            print("getBeers")
        }
    }
}
