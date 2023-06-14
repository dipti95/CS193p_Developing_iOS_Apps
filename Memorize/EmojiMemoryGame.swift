//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dipti Yadav on 6/12/23.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    // static make the variable global
    // emojis is a global
    // typed variable
   private static let emojis = ["🚞", "🚗",  "🛵", "✈️", "🚚", "🚑","🛺", "🚘","🏍️","🚊","🛴","🚁","🚔","🚎","🚓", "🚛","🚐","🚙","🚍","🛻","🏎️","⛵️","⛴️","🚁"]
    
    //typed function
   private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in emojis[pairIndex]}
    }
    
     
    @Published private var model = createMemoryGame()
     
    
    // This is fresh copy because it is from struct
    var cards: Array<Card> {
        return model.cards
    }
    
    
    // Intent(s)
    
    func choose(_ card: Card) {
        //objectWillChange.send()
        model.choose(card)
    }
}

