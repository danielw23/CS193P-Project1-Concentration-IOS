//
//  Cards.swift
//  Project 1: Concentration
//
//  Created by Daniel Wong on 12/29/18.
//  Copyright © 2018 Daniel Wong. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceup = false
    var isMatched = false
    var wasFliped = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
