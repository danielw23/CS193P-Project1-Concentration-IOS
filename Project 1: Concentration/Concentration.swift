//
//  Concentration.swift
//  Project 1: Concentration
//
//  Created by Daniel Wong on 12/29/18.
//  Copyright © 2018 Daniel Wong. All rights reserved.
//

import Foundation

class concentration
{
    var score = 0
    var flipCount = 0
    var cards = [Card]()
    
    private var themesArray:[[String]] =
        [["🐶", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷"],
         ["🐙", "🦑", "🦀", "🦐", "🐡", "🐠", "🐬", "🐳", "🦈"],
         ["🍎", "🍐", "🍊", "🍋", "🍓", "🍈", "🍒", "🍑", "🍆"],
         ["🌭", "🍔", "🍟", "🍕", "🥪", "🥙", "🌮", "🍝", "🍿"],
         ["⚽️", "🏀", "🏈", "⚾️", "🏐", "🏉", "🏓", "🏒", "🏹"],
         ["🎤", "🎹", "🥁", "🎷", "🎲", "🎯", "🎳", "🎼", "🎲"],
         ["🇭🇰", "🇯🇵", "🇨🇦", "🇫🇲", "🇵🇷", "🇰🇷", "🇹🇼", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇬🇧"]]
    var themeChoices: [String]
    var emoji: [Int: String]
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    // get emoji based on card identifier
    func getEmoji(for card: Card) -> String {
        // pop an emoji from themeChoices into emoji if we didn't
        if emoji[card.identifier] == nil, themeChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(themeChoices.count/2)))
            emoji[card.identifier] = themeChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched, !cards[index].isFaceup {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    // they match
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    // update score
                    score += 2
                } else {
                    // not match
                    
                    // update score
                    if cards[matchIndex].wasFliped {
                        score -= 1
                    }
                    if cards[index].wasFliped {
                        score -= 1
                    }
                    
                    cards[matchIndex].wasFliped = true
                    cards[index].wasFliped = true
                }
                
                // flip the card amd set indexOfOneAndOnlyFaceUpCard
                cards[index].isFaceup = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no card or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceup = false
                }
                
                cards[index].isFaceup = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init (numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // Shuffle the cards
        cards = cards.shuffled()
        
        // Initialize emoji
        let randomIndex = Int(arc4random_uniform(UInt32(themesArray.count)))
        themeChoices = themesArray[randomIndex]
        emoji = [Int: String]()
    }
}
