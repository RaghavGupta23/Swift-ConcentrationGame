//
//  Concentration.swift
//  Memory
//
//  Created by admin on 2/11/18.
//  Copyright © 2018 Rooh. All rights reserved.
//

import Foundation
class Concentration
{
    var cards = [Card]()
    var score = 0
    
    private var firstTime = true
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard,
                matchIndex != index {
                if cards[matchIndex].identifier ==
                    cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    if !firstTime {
                        score += 1
                        firstTime = true
                        print("if +1" )
                    }
                    else {
                        firstTime = false
                        print("else +1" )
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                
                if !firstTime {
                    score -= 1
                    firstTime = true
                    print("if -1" )
                }
                else {
                    firstTime = false
                    print("else -1" )
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        }
        
        
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards = randomize(cards: cards)
    }
    
    private func randomize(cards: [Card] ) -> [Card] {
        var cardsCopy: [Card] = cards
        var randomizedCards: [Card] = []
        var randCard: Card
        
        while !cardsCopy.isEmpty {
            randCard = cardsCopy.remove(at: Int(arc4random_uniform(UInt32(cardsCopy.count))))
            randomizedCards.append(randCard)
        }
        
        return randomizedCards
    }

}
