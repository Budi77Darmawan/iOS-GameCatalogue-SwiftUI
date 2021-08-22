//
//  RateView.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 14/08/21.
//

import SwiftUI

struct RateView: View {
  var rate: Float
  let maxRate: Float = 5.0
  
  var body: some View {
    HStack {
      ForEach(1..<Int(maxRate)+1) { index in
        if Int(rate) >= index {
          Image("star_fill")
            .resizable()
            .frame(width: 14, height: 14)
        } else {
          if rate > Float(index - 1) {
            Image("star_half")
              .resizable()
              .frame(width: 14, height: 14)
          } else {
            Image("star_empty")
              .resizable()
              .frame(width: 14, height: 14)
          }
        }
      }
    }
  }
}

struct RateView_Previews: PreviewProvider {
  static var previews: some View {
    RateView(rate: 5.0)
      .previewLayout(.fixed(width: 200, height: 100))
  }
}
