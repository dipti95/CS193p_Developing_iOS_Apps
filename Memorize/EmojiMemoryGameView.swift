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

            
            //[0..<6] zero upto 6 but not including 6
            //[0...6] zero upto 6 including 6
            //            ScrollView {
            //                // LazyVGrid is lazy about accessing the body vars of all of its Views
            //                LazyVGrid (columns: [GridItem(.adaptive(minimum: 100))] ){
            //                    ForEach(game.cards){ card in
            AspectVGrid(items: game.cards,aspectRatio: 2/3, content: {card in
                cardView(for: card)
             })
//               }
//              }
//            }
            .foregroundColor(.red)
            .padding(.horizontal)
    }
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        }else {
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        }
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
       GeometryReader(content: { geometry in
           ZStack{
               let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
               if card.isFaceUp{
                   shape.fill().foregroundColor(.white)
                   shape.strokeBorder(lineWidth:  DrawingConstants.lineWidth)
                   Text(card.content).font(font(in: geometry.size))
               }else if card.isMatched {
                   shape.opacity(0)
               }else {
                   shape.fill()
               }
           }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width,size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
        
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
