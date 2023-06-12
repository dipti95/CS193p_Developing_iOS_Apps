//
//  ContentView.swift
//  Memorize
//
//  Created by Dipti Yadav on 6/8/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack{
            
            //[0..<6] zero upto 6 but not including 6
            //[0...6] zero upto 6 including 6
            ScrollView {
                // LazyVGrid is lazy about accessing the body vars of all of its Views
                LazyVGrid (columns: [GridItem(.adaptive(minimum:65))] ){
                    ForEach(viewModel.cards){ card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
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
    let card: MemoryGame<String>.Card
    
    var body: some View{
       ZStack{
           let shape = RoundedRectangle(cornerRadius: 20)
           if card.isFaceUp{
               shape.fill().foregroundColor(.white)
               shape.strokeBorder(lineWidth:  3)
               Text(card.content).font(.largeTitle)
           }else {
               shape.fill()
           }
       }
    }
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
