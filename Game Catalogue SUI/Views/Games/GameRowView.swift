//
//  GameRowView.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 13/08/21.
//

import SwiftUI
import Kingfisher

struct GameRowView: View {
  var game: Game
  
  var body: some View {
    HStack {
      LoadImageKF(uri: game.backgroundImage ?? Const.defaultUriImage)
        .frame(width: 80, height: 80)
        .clipped()
        .cornerRadius(10)
        .padding(.trailing)
      
      VStack(alignment: .leading, spacing: 2) {
        Text(game.name)
          .font(.system(size: 16))
          .bold()
          .lineLimit(2)
        
        let date = game.released != nil ? ConvertDate.formatDate(date: game.released ?? "") : "-"
        Text("Released: \(date)")
          .font(.system(size: 12))
          .foregroundColor(.gray)
        
        HStack {
          RateView(rate: game.rating ?? 0.0)
          
          let count = game.ratingCount ?? 0
          Text("(\(count))")
            .font(.system(size: 12))
            .foregroundColor(.gray)
        }
        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
      }
      .frame(
        minWidth: 0,
        maxWidth: .infinity,
        minHeight: 0,
        maxHeight: .infinity,
        alignment: .leading
      )
    }
    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
  }
}

struct GameRowView_Previews: PreviewProvider {
  static var previews: some View {
    GameRowView(
      game: Game(
        id: 1,
        slug: "pes 2020",
        name: "Pro Evolution Soccer 2020",
        released: "2020-01-31",
        backgroundImage: "https://i.pinimg.com/originals/cb/1c/f1/cb1cf1bc70e768e1c60e54d46b112b49.jpg",
        rating: 5,
        ratingTop: 5,
        ratingCount: 20531)
    )
    .previewLayout(.fixed(width: 400, height: 100))
  }
}
