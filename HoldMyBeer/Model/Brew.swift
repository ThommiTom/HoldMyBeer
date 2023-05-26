//
//  Brew.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 15.05.23.
//

import Foundation

struct Brew: Identifiable, Hashable, Codable {
    var id: Int { beer.id }
    var beer: Beer
    var steps: Instruction
    var rating: Rating?

    var doneCount: Double {
        Double(steps.doneSteps.count)
    }

    var totalCount: Double {
        Double(steps.doneSteps.count + (steps.currentStep.isEmpty ? 0 : 1) + steps.stepsToDo.count)
    }

    var progress: Double {
        Double(doneCount / totalCount) * 100.0
    }

    var brewDone: Bool {
        doneCount == totalCount
    }

    static var example = Brew(beer: .example, steps: Instruction())
}

struct Instruction: Hashable, Codable {
    var stepsToDo: [String] = []
    var currentStep: String = ""
    var doneSteps: [String] = []
}
