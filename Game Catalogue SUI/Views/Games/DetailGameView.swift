//
//  DetailGameView.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 15/08/21.
//

import SwiftUI

struct DetailGameView: View {
  var gameId: Int
  var gameName: String
  @State private var detail: DetailGame? = nil
  @State private var fromBookmark = false
  @State private var isBookmark = false
  
  @ObservedObject private var gamesViewModel =  GamesViewModel()
  
  var body: some View {
    VStack(alignment: .center) {
      if fromBookmark {
        mainView()
      } else {
        let result = gamesViewModel.detailGame
        switch result {
        case .loading:
          ProgressIndicatorView(color: .blue, size: 50)
        case .success(data: let detailGame):
          mainView()
            .onAppear {
              detail = detailGame
            }
        case .error(message: let error):
          NoContentView(iconName: "icon_error_page", message: error.0)
        }
      }
    }
    .onAppear {
      let detailDB = DatabaseCall.getGameById(id: gameId)
      if detailDB != nil {
        self.detail = detailDB
        self.fromBookmark = true
        self.isBookmark = true
      } else {
        gamesViewModel.getDetailGameById(id: gameId)
        self.fromBookmark = false
        self.isBookmark = false
      }
    }
    .navigationBarTitle(gameName)
    .navigationBarTitleDisplayMode(.inline)
  }
  
  private func mainView() -> some View {
    ScrollView {
      let screenSize = UIScreen.main.bounds
      VStack(alignment: .leading, spacing: nil) {
        LoadImageKF(uri: detail?.backgroundImage ?? Const.defaultUriImage)
          .frame(width: screenSize.width, height: 200)
          .clipped()
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
        
        VStack(alignment: .leading, spacing: nil) {
          HStack {
            Text(gameName)
              .bold()
              .lineLimit(2)
              .font(.system(size: 20))
              .foregroundColor(.black)
              .padding(.trailing, 5)
            
            Spacer()
            buttonBookmarkView()
          }
          Divider()
          
          Text("Description")
            .font(.system(size: 16))
            .foregroundColor(.black)
            .lineLimit(1)
            .padding(.top, 5)
          
          let desc = detail?.description.isEmpty ?? true ? "No Content" : (detail?.description ?? "")
          Text(desc
                .replacingOccurrences(of: "\r\n", with:"" )
                .replacingOccurrences(of: "\n\n", with:"\n" ))
            .font(.system(size: 14))
            .foregroundColor(.gray)
            .lineLimit(.none)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.top, 1)
          
          VStack {
            HStack {
              let rating = detail?.rating != nil ? String(detail?.rating ?? 0) : "-"
              let ratingCount = detail?.ratingCount != nil ? String(detail?.ratingCount ?? 0) : "0"
              let metascore = detail?.metacritic != nil ? String(detail?.metacritic ?? 0) : "-"
              cell(header: "Rating", value: "\(rating) (\(ratingCount) votes)")
              cell(header: "Metascore", value: metascore)
            }
            HStack {
              let listPlatforms = detail?.parentPlatforms ?? []
              cell(header: "Platform", value: ConvertType.listPlatformsToString(list: listPlatforms))
                .padding(.trailing, 5)
              let listGenres = detail?.genres ?? []
              cell(header: "Genre", value: ConvertType.listGenresToString(list: listGenres))
                .padding(.trailing, 5)
            }
            HStack {
              let listDevelopers = detail?.developers ?? []
              cell(header: "Release Date", value: ConvertDate.formatDate(date: detail?.released ?? "-"))
              cell(header: "Developer", value: ConvertType.listDevelopersToString(list: listDevelopers))
                .padding(.trailing, 5)
            }
            HStack {
              let listPublishers = detail?.publishers ?? []
              cell(header: "Publisher", value: ConvertType.listPublishersToString(list: listPublishers))
              cell(header: "Age rating", value: detail?.esrbRating?.name ?? "-")
                .padding(.trailing, 5)
            }
          }
          .padding(.bottom, 15)
          
        }
        .padding(.leading)
        .padding(.trailing)
      }
    }
  }
  
  private func buttonBookmarkView() -> some View {
    Button(action: {
      if isBookmark {
        let stateDelete = DatabaseCall.deleteFromDatabase(gameId: gameId)
        if stateDelete {
          isBookmark = !isBookmark
        }
      } else {
        guard let detailGame = detail else { return }
        let stateAdd = DatabaseCall.addToDatabase(game: detailGame)
        if stateAdd {
          isBookmark = !isBookmark
        }
      }
    }, label: {
      if isBookmark {
        HStack {
          Image(systemName: "bookmark.fill")
            .foregroundColor(.white)
            .frame(width: 18, height: 30, alignment: .center)
          
          Text("Bookmarked")
            .font(.system(size: 14))
            .bold()
            .foregroundColor(.white)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 2)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2)
            .background(Color.blue.cornerRadius(10))
        )
      } else {
        HStack {
          Image(systemName: "bookmark.fill")
            .frame(width: 18, height: 30, alignment: .center)
          
          Text("Add to Bookmark")
            .font(.system(size: 14))
            .bold()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 2)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 1)
        )
      }
    })
  }
  
  private func cell(header: String, value: String) -> some View {
    HStack {
      VStack(alignment: .leading) {
        Text(header)
          .font(.system(size: 16))
          .foregroundColor(.black)
        Text(value)
          .font(.system(size: 14))
          .foregroundColor(.gray)
      }
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .padding(.top, 5)
  }
  
}
