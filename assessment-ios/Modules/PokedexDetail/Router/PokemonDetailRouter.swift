//
//  PokemonDetailRouter.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import SwiftUI

struct PokemonDetailRouter {
  static func createPokemonDetailView(pokemonName: String) -> some View {
    let apiDataManager: PokemonDetailAPIDataManagerProtocol = PokemonDetailAPIDataManager(
      network: UrlSessionNetworking()
    )
    let localDataManager: PokemonDetailLocalDataManagerProtocol = PokemonDetailLocalDataManager()
    let repository: PokemonDetailRepositoryProtocol = PokemonDetailRepository(
      apiDataManager: apiDataManager,
      localDataManager: localDataManager
    )
    let viewModel: PokemonDetailViewModel = PokemonDetailViewModel(
      repository: repository,
      name: pokemonName
    )

    return PokemonDetailView(viewModel: viewModel)
  }
}

