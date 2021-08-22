//
//  ShimmerBannerGameView.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 19/08/21.
//

import SwiftUI

struct ShimmerBannerGameView: View {
  let screenSize = UIScreen.main.bounds
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack(spacing: 10) {
        ShimmerView(width: 6, height: 20, color: .Primary)
        ShimmerView(width: screenSize.width/2.5, height: 20, color: .Primary)
      }
      
      ScrollView {
        HStack {
          ForEach(0..<5) { _ in
            ZStack(alignment: .bottomLeading) {
              ShimmerView(width: screenSize.width-80, height: 200, color: .Secondary)
              ShimmerView(width: screenSize.width/2, height: 20, color: .Secondary)
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
          }
        }
      }
    }
    .padding(.vertical, 5)
  }
}
