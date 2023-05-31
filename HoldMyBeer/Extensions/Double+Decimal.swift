//
//  Double+Decimal.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 31.05.23.
//

import SwiftUI

extension Double {
    func decimalSpecifier(_ specifier: Int) -> String {
        return String(format: "%.\(specifier)f", self)
    }
}
