//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Dipti Yadav on 6/8/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame

    var body: some View {
        VStack{
            
            //[0..<6] zero upto 6 but not including 6
            //[0...6] zero upto 6 including 6
            ScrollView {
                // LazyVGrid is lazy about accessing the body vars of all of its Views
                LazyVGrid (columns: [GridItem(.adaptive(minimum: 65))] ){
                    ForEach(game.cards){ card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
               }
              }
            }
            .foregroundColor(.red)
        }
        .padding(.horizontal)
    }
}


struct CardView: View {
    let card: EmojiMemoryGame.Card
    
// THIS IS NOT BEST WAY TO DO IT BECAUSE IT INCREASES THE EXTRA LINE OF CODE
// FOR JUST DOING CardView(card) INSTAED OF CardView(card: card)
//    private let card: EmojiMemoryGame.Card
//
//    init(_ card: EmojiMemoryGame.Card) {
//        // self.card means this card "private let card: EmojiMemoryGame.Card" because every struct and classes have self variable present
//        self.card = card
//    }
    
    var body: some View{
       ZStack{
           let shape = RoundedRectangle(cornerRadius: 20)
           if card.isFaceUp{
               shape.fill().foregroundColor(.white)
               shape.strokeBorder(lineWidth:  3)
               Text(card.content).font(.largeTitle)
           }else if card.isMatched {
               shape.opacity(0)
           }else {
               shape.fill()
           }
       }
    }
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
