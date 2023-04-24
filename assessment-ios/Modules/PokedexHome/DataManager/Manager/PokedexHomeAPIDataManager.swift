//
//  PokedexHomeAPIDataManager.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation
import Combine

protocol PokedexHomeAPIDataManagerProtocol {
  func getPokemons(offset: Int) -> AnyPublisher<PokemonsModel, APIError>
}

final class PokedexHomeAPIDataManager: PokedexHomeAPIDataManagerProtocol {

  typealias PokemonsResponse = AnyPublisher<Response<PokemonsModel>, APIError>

  private let network: NetworkingProtocol

  init(network: NetworkingProtocol) {
    self.network = network
  }

  func getPokemons(offset: Int) -> AnyPublisher<PokemonsModel, APIError> {
    let pokemonPagination = PokedexParameter(offset: offset, limit: 10)
    let service: PokedexServices = PokedexServices.getPokemonList(pokemonPagination)
    let publisher: PokemonsResponse
    publisher = network.perform(service: service)
    return publisher
      .map(\.value)
      .eraseToAnyPublisher()
  }
}
