//
//  ContentView.swift
//  Memorize
//
//  Created by Dipti Yadav on 6/8/23.
//

import SwiftUI

struct ContentView: View {
    
    var emojis : Array<String> = ["🚞", "🚗",  "🛵", "✈️", "🚚", "🚑","🛺", "🚘","🏍️","🚊","🛴","🚁","🚔","🚎","🚓", "🚛","🏍️", "🚐"]
    
    @State var emojiCount = 4
    
    var body: some View {
        
        VStack{
            
            //[0..<6] zero upto 6 but not including 6
            //[0...6] zero upto 6 including 6
            ScrollView {
                // LazyVGrid is lazy about accessing the body vars of all of its Views
                LazyVGrid (columns: [GridItem(.adaptive(minimum:65))] ){
                    ForEach(emojis[0..<emojiCount], id : \.self ){ emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack{
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
    
        }
        .padding(.horizontal)
        
    }
    
    var remove: some View{
        Button {
            if emojiCount > 1{
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    
    var add: some View{
        Button {
            if emojiCount < emojis.count{
                emojiCount += 1
              }
            } label: {
            Image(systemName: "plus.circle")
        }

    }
        
    
}


struct CardView: View {
    var content: String
    
   @State var isFaceUp: Bool = true
    
    var body: some View{
       ZStack{
           let shape = RoundedRectangle(cornerRadius: 20)
           if isFaceUp{
               shape.fill().foregroundColor(.white)
               shape.strokeBorder(lineWidth:  3)
               
               Text(content)
                   .font(.largeTitle)
           }else {
               shape.fill()
           }
       }.onTapGesture{
           isFaceUp = !isFaceUp
       }
    }
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
