//
//  PokedexHomeRepository.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation
import Combine

protocol PokedexHomeRepositoryProtocol {
  func getPokemons(offset: Int) -> AnyPublisher<[PokemonModel], Error>
}

struct PokedexHomeRepository: PokedexHomeRepositoryProtocol {

  // MARK: - Properties
  let apiDataManager: PokedexHomeAPIDataManagerProtocol
  let localDataManager: PokedexHomeLocalDataManagerProtocol

  // MARK: Initializer
  init(
    apiDataManager: PokedexHomeAPIDataManagerProtocol,
    localDataManager: PokedexHomeLocalDataManagerProtocol
  ) {
    self.apiDataManager = apiDataManager
    self.localDataManager = localDataManager
  }

  func getPokemons(offset: Int) -> AnyPublisher<[PokemonModel], Error> {
    apiDataManager.getPokemons(offset: offset)
      .map{ $0.pokemons }
      .flatMap { saveIfNeeded(model: $0, offset: offset) }
      .catch { error -> AnyPublisher<[PokemonModel], Error> in
        switch error {
        case .noNetwork:
          return getLocalPokemonsData(offset: offset)
        default:
          return Fail(error: error)
            .eraseToAnyPublisher()
        }
      }
      .eraseToAnyPublisher()
  }

  private func saveIfNeeded(model: [PokemonModel], offset: Int) -> AnyPublisher<[PokemonModel], Never> {

    return localDataManager.savePokemonsModelIfNeeded(model: model, offset: offset)
      .map{ _ in
        return model
      }
      .eraseToAnyPublisher()
  }

  private func getLocalPokemonsData(offset: Int) -> AnyPublisher<[PokemonModel], Error> {
    localDataManager.getLocalPokemonsData(offset: offset)
      .eraseToAnyPublisher()
  }
}
