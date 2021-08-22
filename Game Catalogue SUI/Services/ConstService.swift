//
//  ConstService.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 13/08/21.
//

import Foundation

struct ConstService {
  
  static let BaseAPI = "https://api.rawg.io/api/"
  static let KeyAPI = "INPUT YOUR API KEY"
  
  
  struct rawgType {
    static let games = "games"
    static let detailGameById = games + "/{id}"
  }
}
