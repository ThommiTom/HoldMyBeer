//
//  EBCScale.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 14.05.23.
//

import SwiftUI

class EBCScale {
    static func getColor(by ebc: Double) -> Color {
        let ebc = Int(ebc)
        
        switch ebc {
        case ...4:
            return .ebc4
        case 5...79:
            return self.findColor(for: ebc)
        case 80...:
                return .ebc79
        default:
            return .white
        }
    }
    
    private init() {}
    
    static private let ebcColors: [ClosedRange<Int> : Color] = [
        0...4: .ebc4,
        5...6: .ebc6,
        7...8: .ebc8,
        9...12: .ebc12,
        13...16: .ebc16,
        17...20: .ebc20,
        21...26: .ebc26,
        27...33: .ebc33,
        34...39: .ebc39,
        40...47: .ebc47,
        48...57: .ebc57,
        58...69: .ebc69,
        70...79: .ebc79
    ]
    
    static private func findColor(for ebc: Int) -> Color {
        for color in ebcColors {
            if color.key.contains(ebc) {
                return color.value
            }
        }
        
        return .white
    }
}
