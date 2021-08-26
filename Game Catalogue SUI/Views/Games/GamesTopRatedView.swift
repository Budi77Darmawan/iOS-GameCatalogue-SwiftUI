//
//  GamesTopRatedView.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 23/08/21.
//

import SwiftUI

struct GamesTopRatedView: View {
  @ObservedObject var gamesViewModel =  GamesViewModel()
  let screenSize = UIScreen.main.bounds
  
  var body: some View {
    List {
      let gamesTopRated = gamesViewModel.listGamesTopRated
      switch gamesTopRated {
      case .success(data: let games):
        let games = games?.results ?? []
        if games.count > 0 {
          ForEach(games) { game in
            ZStack {
              NavigationLink(destination: DetailGameView(gameId: game.id, gameName: game.name)) {
                GameRowView(game: game).onAppear {
                  gamesViewModel.loadNextPageGames(lastGame: game, type: GameType.topRated)
                }
              }
            }
          }
        } else {
          ErrorView(iconName: "icon_empty_items", msg: "Game list not available")
        }
        
      case .loading:
        shimmerListGamesView()
          .onAppear {
            gamesViewModel.getGamesTopRated()
          }
        
      case .error(message: let error):
        ErrorView(iconName: "icon_error_page", msg: error.0)
        
      }
    }
    .navigationBarTitle("Top Rated")
  }
  
  private func shimmerListGamesView() -> some View {
    VStack {
      ShimmerGameRowView(withTitle: false)
    }
  }
  
  private func ErrorView(iconName: String, msg: String?) -> some View {
    NoContentView(iconName: iconName, message: msg)
      .frame(maxWidth: .infinity, minHeight: screenSize.height/1.25)
  }
}
