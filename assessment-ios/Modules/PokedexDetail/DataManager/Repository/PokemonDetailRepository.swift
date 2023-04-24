//
//  PokemonDetailRepository.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation
import Combine

protocol PokemonDetailRepositoryProtocol {
  func getPokemonDetail(name: String) -> AnyPublisher<PokemonDetail, APIError>
}

struct PokemonDetailRepository: PokemonDetailRepositoryProtocol {

  // MARK: - Properties
  let apiDataManager: PokemonDetailAPIDataManagerProtocol
  let localDataManager: PokemonDetailLocalDataManagerProtocol

  // MARK: Initializer
  init(
    apiDataManager: PokemonDetailAPIDataManagerProtocol,
    localDataManager: PokemonDetailLocalDataManagerProtocol
  ) {
    self.apiDataManager = apiDataManager
    self.localDataManager = localDataManager
  }

  func getPokemonDetail(name: String) -> AnyPublisher<PokemonDetail, APIError> {
    apiDataManager.getPokemonDetail(name: name)
  }
}
