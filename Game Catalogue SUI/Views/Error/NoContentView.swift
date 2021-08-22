//
//  NoItemsView.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 16/08/21.
//

import SwiftUI

struct NoContentView: View {
  var iconName: String
  var message: String?
  
  var body: some View {
    VStack(alignment: .center, spacing: 5) {
      Image(iconName)
        .resizable()
        .frame(width: 120, height: 120)
      
      if message != nil {
        Text(message ?? "")
          .font(.system(size: 16))
          .multilineTextAlignment(.center)
          .padding(.top, 10)
      }
    }
  }
}

struct NoContentView_Previews: PreviewProvider {
  static var previews: some View {
    NoContentView(iconName: "icon_error_page", message: "Internal server error")
      .previewLayout(.fixed(width: 300, height: 300))
  }
}
