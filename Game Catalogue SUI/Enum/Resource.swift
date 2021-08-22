//
//  RequestStatus.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 17/08/21.
//

import Foundation

enum Resource<T> {
  case loading
  case error(
        message: String? = "Internal Server Error",
        data: T? = nil
       )
  case success(data: T? = nil)
}
