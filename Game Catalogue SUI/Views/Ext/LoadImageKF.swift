//
//  LoadImageKF.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 15/08/21.
//

import Foundation
import SwiftUI
import Kingfisher

public struct LoadImageKF: View {
  var uri: String
  
  public var body: some View {
    KFImage.url(URL(string: uri))
      .resizable()
      .loadDiskFileSynchronously()
      .diskCacheExpiration(.never)
      .fade(duration: 0.25)
      .aspectRatio(contentMode: .fill)
  }
  
}
