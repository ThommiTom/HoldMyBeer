//
//  BeerManager+Instructions.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 15.05.23.
//

import Foundation

extension BrewManager {
    func setBrewInstructionsMockUp() -> Instruction {
        var instructions = Instruction()

        instructions.currentStep = "Gather ingredients"
        instructions.stepsToDo.append("Boil Malts with plenty of water")
        instructions.stepsToDo.append("At the start of boil process add start hops")
        instructions.stepsToDo.append("During the middle of boil process add middle hops")
        instructions.stepsToDo.append("Towards the end of boil process add end hops")
        instructions.stepsToDo.append("Let the brew cool down")
        instructions.stepsToDo.append("Add yeast and start fermentation process")
        instructions.stepsToDo.append("Wait until fermentation finshes")

        return instructions
    }

    //    func setBrewInstruction(for beer: Beer) -> [Instruction] {
    //        // in case ingredients or method are missing, there is no point to continue
    //        guard let ingredients = beer.ingredients else { return [] }
    //
    //        var instructions = [Instruction]()
    //
    //        // 1. start off with brewer tip
    //        if let tip = beer.brewers_tips {
    //            instructions.append(Instruction(id: 0,
    //                                            instruction: "Before we beginn, here's a brewers tip: \n\(tip)",
    //                                            state: .toDo))
    //        }
    //
    //        // 2. gather malts
    //        var malts = ""
    //        for malt in ingredients.malt {
    //            malts.append("\(malt) ")
    //        }
    //
    //        var instruction: String =
    //        """
    //        Gather the following malts:
    //        \(malts)
    //        """
    //
    //        instructions.append(Instruction(id: 0,
    //                                        instruction: instruction,
    //                                        state: .toDo))
    //
    //        // 3. boil malts with water
    //        instructions.append(Instruction(id: 0,
    //                                        instruction: "Boil malts with water",
    //                                        state: .toDo))
    //
    //        // 4. gather hops
    //        var hopsAtStart = ""
    //        var hopsInMiddle = ""
    //        var hopsAtEnd = ""
    //        for hop in ingredients.hops {
    //            switch hop.add {
    //            case "start":
    //                hopsAtStart.append("\(hop.name) ")
    //            case "middle":
    //                hopsInMiddle.append("\(hop.name) ")
    //            case "end":
    //                hopsAtEnd.append("\(hop.name) ")
    //            default:
    //                break
    //            }
    //        }
    //
    //        instruction =
    //        """
    //        Gather the following hops:
    //        \(hopsAtStart) \(hopsInMiddle) \(hopsAtEnd)
    //        """
    //
    //        instructions.append(Instruction(id: 0,
    //                                        instruction: instruction,
    //                                        state: .toDo))
    //
    //        // 5. add start hops
    //        instructions.append(Instruction(id: 0,
    //                                        instruction: "At start of boiling add \(hopsAtStart)",
    //                                        state: .toDo))
    //
    //        // 6. add middle hops
    //        instructions.append(Instruction(id: 0,
    //                                        instruction: "In middle of boiling add \(hopsInMiddle)",
    //                                        state: .toDo))
    //
    //        // 7. add end hops
    //        instructions.append(Instruction(id: 0,
    //                                        instruction: "At end of boiling add \(hopsAtEnd)",
    //                                        state: .toDo))
    //
    //        // 8. cool down, add yeast and start fermetnation
    //        instructions.append(Instruction(id: 0,
    //                                        instruction: "Cool brew down, Add Yeast, Wait fermentation to finish!",
    //                                        state: .toDo))
    //
    //        return instructions
    //    }
}
