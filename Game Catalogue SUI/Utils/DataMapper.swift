//
//  DataMapper.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 17/08/21.
//

import Foundation

class DataMapper {
  
  static func mapDetailToGame(detail: DetailGame) -> Game {
    return Game (
      id: detail.id,
      slug: detail.slug,
      name: detail.name,
      released: detail.released,
      backgroundImage: detail.backgroundImage,
      rating: detail.rating,
      ratingTop: detail.ratingTop,
      ratingCount: detail.ratingCount
    )
  }
}
