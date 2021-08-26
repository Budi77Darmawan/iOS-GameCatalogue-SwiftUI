//
//  ShimmerGameRowView.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 16/08/21.
//

import SwiftUI

struct ShimmerGameRowView: View {
  var withTitle: Bool = true
  let screenSize = UIScreen.main.bounds
  
  var body: some View {
    VStack(alignment: .leading) {
      if withTitle {
        HStack(spacing: 10) {
          ShimmerView(width: 6, height: 20, color: .Primary)
          ShimmerView(width: screenSize.width/2.5, height: 20, color: .Primary)
        }
      }
      
      ForEach(0..<7) { _ in
        HStack {
          ShimmerView(width: 80, height: 80, color: .Primary)
            .padding(.trailing)
          
          VStack(alignment: .leading, spacing: 0.01) {
            ShimmerView(width: 250, height: 18, color: .Primary)
            ShimmerView(width: 180, height: 12, color: .Secondary)
            
            HStack {
              ShimmerView(width: 150, height: 14, color: .Secondary)
              ShimmerView(width: 50, height: 14, color: .Secondary)
            }
            .padding(.top, 3)
          }
        }
        .padding(.vertical, 5)
      }
    }
  }
}

struct ShimmerGameRowView_Previews: PreviewProvider {
  static var previews: some View {
    ShimmerGameRowView()
  }
}
