//
//  ContentView.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 13/08/21.
//

import SwiftUI

struct ContentView: View {
  
  var body: some View {
    NavigationView {
      TabView {
        GamesView()
          .tabItem {
            Image(systemName: "gamecontroller.fill")
            Text("Games")
          }
        BookmarkView()
          .tabItem {
            Image(systemName: "bookmark.fill")
            Text("Bookmark")
          }
        ProfileView()
          .tabItem {
            Image(systemName: "person.fill")
            Text("Profile")
          }
      }
      .navigationTitle("Games Catalogue")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}
