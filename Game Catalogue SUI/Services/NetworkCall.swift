//
//  NetworkCall.swift
//  Game Catalogue SUI
//
//  Created by Budi Darmawan on 13/08/21.
//

import Foundation
import Alamofire

class NetworkCall : NSObject {
  
  var url: String = ConstService.BaseAPI
  var method: HTTPMethod = .get
  var parameters: Parameters? = nil
  
  init(url: String, params: Parameters?){
    super.init()
    self.url += url
    self.parameters = params
  }
  
  func executeQuery<T> (completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
    DispatchQueue.main.async {
      AF.request(self.url, method: self.method, parameters: self.parameters)
        .validate(statusCode: 200...299)
        .responseJSON { response in
          switch response.result {
          case .success:
            guard let data = response.data else { return }
            do {
              let result = try JSONDecoder().decode(T.self, from: data)
              completion(.success(result))
            } catch let error {
              print("\n\nERROR API DECODE - \(error)\n\n")
              completion(.failure(error))
            }
          case .failure(let error):
            print("\n\nERROR API - \(error)\n\n")
            completion(.failure(error))
          }
        }
    }
  }
}

