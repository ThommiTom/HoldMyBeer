//
//  BrewProcess.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 15.05.23.
//

import Foundation

struct Brew: Identifiable, Hashable, Codable {
    var id: Int { beer.id }
    var beer: Beer
    var process: [Instruction]
    
    static var example = Brew(beer: .example, process: [Instruction]())
}

struct Instruction: Hashable, Codable {
    var stepDone: Date?
    var instruction: String
    var state: ProgressState
}

enum ProgressState: String, Hashable, Codable {
    case toDo = "TO DO"
    case inProgress = "IN PROGRESS"
    case done = "DONE"
}
