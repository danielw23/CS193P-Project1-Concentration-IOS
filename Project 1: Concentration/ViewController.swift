//
//  ViewController.swift
//  Project 1: Concentration
//
//  Created by Daniel Wong on 12/29/18.
//  Copyright © 2018 Daniel Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2 )
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            updateLabel()
        } else {
            print("chose card was not in cardButtons!")
        }
    }
    
    // Ends the current game in progress and begins a brand new game
    @IBAction func startNewGame(_ sender: Any) {
        game = concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2 )
        updateViewFromModel()
        updateLabel()
    }
    
    // Update cards' apperence
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceup {
                button.setTitle(game.getEmoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
            
        }
    }
    
    // Update score and flip labels
    func updateLabel() {
        scoreLabel.text = "Scores: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }


}

