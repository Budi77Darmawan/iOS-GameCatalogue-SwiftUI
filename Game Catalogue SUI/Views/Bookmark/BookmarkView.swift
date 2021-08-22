//
//  BookmarkView.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 13/08/21.
//

import SwiftUI

struct BookmarkView: View {
  @State var listGame: [DetailGame] = []
  
  var body: some View {
    List {
      if listGame.count > 0 {
        ForEach(listGame) { detailGame in
          let mapGame = DataMapper.mapDetailToGame(detail: detailGame)
          ZStack {
            GameRowView(game: mapGame)
            NavigationLink(destination: DetailGameView(gameId: mapGame.id, gameName: mapGame.name)) {
              EmptyView()
            }
          }
        }
      } else {
        let screenSize = UIScreen.main.bounds
        NoContentView(iconName: "icon_empty_items", message: "The Bookmark is empty")
          .frame(maxWidth: .infinity, minHeight: screenSize.height/1.25)
        
      }
    }
    .onAppear {
      listGame = DatabaseCall.getGamesOnDatabase()
    }
  }
}

struct BookmarkView_Previews: PreviewProvider {
  static var previews: some View {
    BookmarkView()
  }
}
