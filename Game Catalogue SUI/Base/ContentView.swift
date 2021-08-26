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
    .navigationViewStyle(StackNavigationViewStyle())
    .onAppear {
      Profile.synchronize()
      let dataProfile = Profile.objProfile
      if dataProfile.name.isEmpty || dataProfile.numberPhone.isEmpty || dataProfile.email.isEmpty {
        Profile.objProfile = Profile(name: "Budi Darmawan", numberPhone: "0822-1111-2222", email: "budi@buaya.com")
      }
    }
  }
}
