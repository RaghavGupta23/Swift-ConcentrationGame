//
//  ViewController.swift
//  Memory
//
//  Created by admin on 2/11/18.
//  Copyright © 2018 Rooh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards:(cardbuttons.count + 1) / 2)
    
    var theme: [String] = []
    var emoji = [Int:String]()
    var gameStarted:Bool = false
    
    var emojiChoices = [
        ["😀", "☺️", "😘", "🤑", "😞", "😫", "😯", "🤗", "🤓", "😎", "😋", "😜", "🤠"],
        ["😈", "👿", "👹", "👺", "💩", "👻", "💀", "☠️", "👽", "👾", "🤖", "🎃", "😺"],
        ["👐", "🙌", "👏", "🙏", "🤝", "👍", "👎", "👊🏻", "✊", "🤞", "🤘", "👌", "👈"],
        ["👪", "👨‍👩‍👧", "👨‍👩‍👧‍👦", "👨‍👩‍👦‍👦", "👨‍👩‍👧‍👧", "👩‍👩‍👦", "👩‍👩‍👧", "👩‍👩‍👧‍👦", "👩‍👩‍👦‍👦", "👩‍👩‍👧‍👧", "👨‍👨‍👦", "👨‍👨‍👧", "👨‍👨‍👧‍👦"],
        ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷"]
    ]
    
    var flipCount = 0{
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var scoreCount = 0{
        didSet {
            scoreCountLabel.text = "Score: \(scoreCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardbuttons: [UIButton]!
    
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if (!gameStarted) {
            print("game not started yet")
            return
        }
        flipCount += 1
        let cardNumber = cardbuttons.index(of: sender)
        //let card = game.cards[cardNumber!]
        game.chooseCard(at: cardNumber!)
        updateViewFromModel()
        
    }
    
    @IBAction func resetGame(_ sender: Any) {
        gameStarted = true
        theme = choseTheme()
        game = Concentration(numberOfPairsOfCards:(cardbuttons.count + 1) / 2)
        for index in cardbuttons.indices {
            let button = cardbuttons[index]
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.04128915078, blue: 0.05656034056, alpha: 1)
        }
        flipCount = 0
        scoreCount = 0
    }
    
    func updateViewFromModel() {
        for index in cardbuttons.indices {
            let button = cardbuttons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for:
                    UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.002407962329) : #colorLiteral(red: 1, green: 0.04128915078, blue: 0.05656034056, alpha: 1)
            }
        }
        scoreCount = game.score
    }
    
    
    
    func choseTheme() -> [String] {
        let theme: Int = Int(arc4random_uniform(UInt32(emojiChoices.count)))
        return emojiChoices[theme]
    }
    
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(theme.count)))
             emoji[card.identifier] = theme.remove(at:randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
