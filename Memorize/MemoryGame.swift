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
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter({cards[$0].isFaceUp})
            return faceUpCardIndices.oneAndOnly
            // oneAndOnly is an array extension we is written in the end of this file
            // THE ABOVE TWO LINE WILL BE WRITTEN LIKE THIS WITHOUT RETURN cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly
            
            //ABOVE CODE IS THE SHORT WAY TO WRITE THE BELOW CODE
            
//            var faceUpCardIndices = [Int]()
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    faceUpCardIndices.append(index)
//                }
//            }
//            if faceUpCardIndices.count == 1 {
//                // we can use faceUpCardIndices[0] as well as faceUpCardIndices.first.
//                // In .first if faceUpCardIndices will empty it will return nil.
//                return faceUpCardIndices.first
//            }else {
//                return nil
//            }
        }
        set {
            cards.indices.forEach {cards[$0].isFaceUp = ($0 == newValue)}
            
//            for index in cards.indices {
//                // set provide the variable newValue variable
//                // So if indexOfTheOneAndOnlyFaceUpCard = chosenIndex then the newValue is chosenIndex
//                if index != newValue {
//                    cards[index].isFaceUp = false
//                }else {
//                    cards[index].isFaceUp = true
//                }
//            }
        }
    }
     
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
               cards[chosenIndex].isFaceUp = true
           } else {
               indexOfTheOneAndOnlyFaceUpCard = chosenIndex
           }
        }
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
        cards = []
        // add numberOfParirsOfCards * 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
//content and id is initialized by let because we know that the value of these will never change
        let content: CardContent
        let id: Int
        
    }
}

extension Array{
    // we write Element we we don't care about type of var inside an array
    // ? for optional beacuse if the array is empty we want to return nil
    var oneAndOnly: Element? {
         if count == 1 {
         return first
         }else {
            return nil
        }
    }
}
