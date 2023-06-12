//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Dipti Yadav on 6/12/23.
//

import SwiftUI


class EmojiMemoryGame {
    
    // static make the variable global
    // emojis is a global
    // typed variable
   static let emojis : Array<String> = ["🚞", "🚗",  "🛵", "✈️", "🚚", "🚑","🛺", "🚘","🏍️","🚊","🛴","🚁","🚔","🚎","🚓", "🚛","🚐","🚙","🚍","🛻","🏎️","⛵️","⛴️","🚁"]
    
    //typed function
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in emojis[pairIndex]}
    }
     
    private var model: MemoryGame<String> = createMemoryGame()
     
    
    // This is fresh copy because it is from struct
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}

