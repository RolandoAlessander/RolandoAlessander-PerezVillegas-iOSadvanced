//
//  PokedexParameters.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation

struct PokedexParameter: QueryParamsProtocol {
  var offset: Int
  var limit: Int

  func getQueryParams() -> [URLQueryItem] {
    return [
      URLQueryItem(name: "offset", value: String(offset)),
      URLQueryItem(name: "limit", value: String(limit))
    ]
  }
}
