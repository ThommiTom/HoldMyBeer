//
//  InstructionListView.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 15.05.23.
//

import SwiftUI

struct InstructionListView: View {
    let instructions: [String]
    let viewTitle: String

    var body: some View {
        List {
            ForEach(instructions, id: \.self) { instruction in
                Text(instruction)
            }
        }
        .listStyle(.plain)
        .navigationTitle(viewTitle)
    }
}

struct InstructionListView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionListView(instructions: [String](), viewTitle: "Test")
    }
}
