//
//  MemoryGame.swift
//  Memorize
//
//  Created by Dipti Yadav on 6/12/23.
//

import Foundation

//CardContent type we don't care so we have to announce so that somebody uses this game then they can know what this "don't care" is.
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    
    // first of all the below variable value is none because we want for our game so that's why we put question mark which represent optional so that below variable will have value none or int
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
     
   mutating func choose(_ card: Card) {
       //if let is the part of syntheic sugar which is provided by swift
     if let chosenIndex = cards.firstIndex(where: {$0.id == card.id }),    !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
       {
           if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
               if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                   cards[chosenIndex].isMatched = true
                   cards[potentialMatchIndex].isMatched = true
               }
               indexOfTheOneAndOnlyFaceUpCard = nil
           } else {
               for index in cards.indices {
                   cards[index].isFaceUp = false
               }
               indexOfTheOneAndOnlyFaceUpCard = chosenIndex
           }
           
           cards[chosenIndex].isFaceUp.toggle()
       }
        print("\(cards)")
    }
    
    //this "if let chosenIndex = cards.firstIndex(where: {$0.id == card.id })" expresssion replaces below function.
    
    // question mark after Int means Optional.
//    func index(of card: Card) -> Int? {
//        for index in 0..<cards.count {
//            if cards[index].id == card.id {
//                return index
//            }
//        }
//        return nil
//    }
    
    init(numberOfPairsOfCards: Int, createCardContent:(Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfParirsOfCards * 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
//content and id is initialized by let because we know that the value of these will never change
        let content: CardContent
        let id: Int
        
    }
}
