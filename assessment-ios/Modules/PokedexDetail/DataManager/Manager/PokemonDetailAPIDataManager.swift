//
//  PokemonDetailAPIDataManager.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation
import Combine

protocol PokemonDetailAPIDataManagerProtocol {
  func getPokemonDetail(name: String) -> AnyPublisher<PokemonDetail, APIError>
}

final class PokemonDetailAPIDataManager: PokemonDetailAPIDataManagerProtocol {

  typealias PokemonDetailResponse = AnyPublisher<Response<PokemonDetail>, APIError>

  private let network: NetworkingProtocol

  init(network: NetworkingProtocol) {
    self.network = network
  }

  func getPokemonDetail(name: String) -> AnyPublisher<PokemonDetail, APIError> {
    let service: PokedexServices = PokedexServices.getPokemonDetail(name: name)
    let publisher: PokemonDetailResponse
    publisher = network.perform(service: service)
    return publisher
      .map(\.value)
      .eraseToAnyPublisher()
  }
}
