//
//  SplashScreenView.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 15/08/21.
//

import SwiftUI

struct SplashScreenView: View {
  @State var isActive: Bool = false
  
  var body: some View {
    ZStack {
      if self.isActive {
        ContentView()
      } else {
        VStack(alignment: .center, spacing: 5) {
          Image("icon_logo")
            .resizable()
            .frame(width: 150, height: 150)
          
          Text("Game Catalogue")
            .font(.system(size: 30))
            .bold()
            .multilineTextAlignment(.center)
        }
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        withAnimation {
          self.isActive = true
        }
      }
    }
  }
}

struct SplashScreenView_Previews: PreviewProvider {
  static var previews: some View {
    SplashScreenView()
      .previewLayout(.fixed(width: 400, height: 400))
  }
}
