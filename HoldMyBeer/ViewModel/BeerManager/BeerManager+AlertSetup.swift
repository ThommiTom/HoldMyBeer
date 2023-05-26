//
//  BeerManager+AlertSetup.swift
//  HoldMyBeer
//
//  Created by Thomas Schatton on 15.05.23.
//

import Foundation

extension BeerManager {
    func setAlert() {
        DispatchQueue.main.async {
            self.alertData.title = "Oops..."
            self.alertData.message = "Sorry, we couldn't find what you're looking for... 😕"
            self.alertData.show = true
        }
    }

    func setErrorAlert(with error: NetworkError) {
        DispatchQueue.main.async {
            self.alertData.title = "Oops..."
            self.alertData.message = "Sorry, something went horrobly wrong... 😔\n\(error.rawValue) 😪"
            self.alertData.show = true
        }
    }
}
