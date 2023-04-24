//
//  PokedexServices.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation

enum PokedexServices: Service {
  case getPokemonList(PokedexParameter)
  case getPokemonDetail(name: String)

  var baseURl: String {
    return "https://pokeapi.co/api/v2"
  }

  var endPoint: String {
    switch self {
    case .getPokemonList:
      return "/pokemon"
    case .getPokemonDetail(let name):
      return "/pokemon/\(name)"
    }
  }

  var httpMethod: HTTPMethod {
    return .get
  }

  var parameterEncoding: ParametersEncodingProtocol {
    return ParametersEncoding.init(parameterType: .queryItem)
  }

  var parameters: QueryParamsProtocol? {
    switch self {
    case .getPokemonList(let params):
      return params
    case .getPokemonDetail:
      return nil
    }
  }
}
