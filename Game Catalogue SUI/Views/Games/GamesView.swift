//
//  GamesView.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 13/08/21.
//

import SwiftUI

struct GamesView: View {
  @ObservedObject var gamesViewModel =  GamesViewModel()
  let screenSize = UIScreen.main.bounds
  @State private var searchText = ""
  @State private var showCancelButton = false
  @State private var debouncer: Debouncer?
  
  init() {
    UITableView.appearance().showsVerticalScrollIndicator = false
  }
  
  var body: some View {
    VStack {
      List {
        Section(header: searchView()) {
          
          if !showCancelButton {
            let gamesTopRated = gamesViewModel.listGamesTopRated
            switch gamesTopRated {
            case .loading:
              shimmerTopRatedGamesView()
                .onAppear {
                  gamesViewModel.getGamesTopRated()
                }
            case .success(data: let games):
              topRatedView(games: games)
                .padding(.top, 3)
            case .error:
              EmptyView()
            }
            
            let listGames = gamesViewModel.listGames
            switch listGames {
            case .loading:
              shimmerListGamesView()
                .onAppear {
                  gamesViewModel.getDataGames()
                }
            case .success(data: let games):
              let games = games?.results ?? []
              if games.count > 0 {
                Section {
                  HStack(spacing: 10) {
                    Capsule()
                      .fill(Color.blue)
                      .frame(width: 5, height: 25)
                    Text("List Games")
                    Spacer()
                  }
                  .padding(.top)
                  .padding(.bottom, 10)
                }
                
                ForEach(games) { game in
                  listGameView(game: game)
                }
              } else {
                ErrorView(iconName: "icon_empty_items", msg: "Game list not available")
              }
              
            case .error(message: let error):
              ErrorView(iconName: "icon_error_page", msg: error.0)
            }
          } else {
            let searhQuery = searchText.trimmingCharacters(in: .whitespaces)
            if searhQuery.isEmpty {
              ErrorView(iconName: "icon_search", msg: "Waiting to search")
            } else {
              let listGamesBySearch = gamesViewModel.listGamesBySearch
              switch listGamesBySearch {
              case .loading:
                shimmerListGamesView()
              case .success(data: let games):
                let games = games?.results ?? []
                if games.count > 0 {
                  Section {
                    HStack(spacing: 10) {
                      Capsule()
                        .fill(Color.blue)
                        .frame(width: 5, height: 25)
                      Text("List Games \"\(searchText.trimmingCharacters(in: .whitespaces))\"")
                      Spacer()
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 10)
                  }
                  ForEach(games) { game in
                    listGameView(game: game)
                  }
                } else {
                  ErrorView(iconName: "icon_error_search", msg: "Game \"\(searhQuery)\" not found!")
                }
                
              case .error(message: let error):
                ErrorView(iconName: "icon_error_page", msg: error.0)
              }
            }
          }
        }
        .listRowInsets(EdgeInsets(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: 0))
      }
      .resignKeyboardOnDragGesture()
    }
    .onAppear {
      debouncer = Debouncer(delay: 0.5, callback: {
        let searchQuery = searchText.trimmingCharacters(in: .whitespaces)
        gamesViewModel.getGamesBySearch(query: searchQuery)
      })
    }
    .padding(.top, 10)
    .padding(.bottom, 5)
    .padding(.horizontal)
  }
  
  private func searchView() -> some View {
    VStack {
      HStack {
        HStack {
          Image(systemName: "magnifyingglass")
          
          TextField("Search", text: Binding<String>(
                      get: { self.searchText },
                      set: {
                        self.showCancelButton = true
                        self.searchText = $0
                        debouncer?.call()
                      }), onEditingChanged: { isEditing in
                        self.showCancelButton = true
                      }
          )
          .foregroundColor(.primary)
          
          Button(action: {
            self.searchText = ""
          }) {
            Image(systemName: "xmark.circle.fill")
              .opacity(searchText == "" ? 0 : 1)
          }
        }
        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)
        
        if showCancelButton  {
          Button("Cancel") {
            UIApplication.shared.endEditing(true)
            self.searchText = ""
            self.showCancelButton = false
          }
          .foregroundColor(Color(.systemBlue))
        }
      }
      Rectangle()
        .frame(maxWidth: .infinity, maxHeight: 1)
        .foregroundColor(.white)
    }
    .background(Color.white)
    .navigationBarHidden(showCancelButton)
  }
  
  private func topRatedView(games: Games?) -> some View {
    VStack {
      HStack(spacing: 10) {
        Capsule()
          .fill(Color.blue)
          .frame(width: 5, height: 25)
        Text("Top Rated")
        Spacer()
      }
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack{
          let listGame = games?.results ?? []
          if listGame.count > 0 {
            let NewListGame = listGame[0..<5]
            ForEach(NewListGame) { game in
              NavigationLink(
                destination: DetailGameView(gameId: game.id, gameName: game.name)) {
                ZStack(alignment: .bottomLeading) {
                  LoadImageKF(uri: game.backgroundImage ?? Const.defaultUriImage)
                    .frame(width: screenSize.width - 80, height: 200)
                    .clipped()
                    .cornerRadius(10)
                    .padding(.trailing, 10)
                  
                  HStack {
                    Text(game.name)
                      .font(.system(size: 14))
                      .foregroundColor(.white)
                      .bold()
                      .padding(.vertical, 3)
                      .padding(.horizontal, 5)
                      .background(Color.gray)
                      .cornerRadius(6)
                      .padding(.all, 10)
                  }
                  .frame(width: screenSize.width - 80, alignment: .leading)
                }
              }
            }
          }
        }
      }
    }
  }
  
  private func listGameView(game: Game) -> some View {
    ZStack {
      GameRowView(game: game)
        .onAppear {
          print("List Game: \(game.name)")
          if searchText.isEmpty {
            gamesViewModel.loadNextPageGames(lastGame: game)
          }
        }
      NavigationLink(destination: DetailGameView(gameId: game.id, gameName: game.name)) {
        EmptyView()
      }
    }
  }
  
  private func shimmerListGamesView() -> some View {
    VStack {
      ShimmerGameRowView()
    }
  }
  
  private func shimmerTopRatedGamesView() -> some View {
    VStack {
      ShimmerBannerGameView()
    }
  }
  
  private func ErrorView(iconName: String, msg: String?) -> some View {
    NoContentView(iconName: iconName, message: msg)
      .frame(maxWidth: .infinity, minHeight: screenSize.height/1.25)
  }
}
