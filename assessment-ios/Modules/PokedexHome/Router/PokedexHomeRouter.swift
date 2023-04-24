//
//  PokedexHomeRouter.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import SwiftUI

struct PokedexHomeRouter {
  static func createPokedexHomeView() -> some View {
    let apiDataManager: PokedexHomeAPIDataManagerProtocol = PokedexHomeAPIDataManager(
      network: UrlSessionNetworking()
    )
    let localDataManager: PokedexHomeLocalDataManagerProtocol = PokedexHomeLocalDataManager()
    let repository: PokedexHomeRepositoryProtocol = PokedexHomeRepository(
      apiDataManager: apiDataManager,
      localDataManager: localDataManager
    )
    let viewModel: PokedexHomeViewModel = PokedexHomeViewModel(
      repository: repository
    )

    return PokedexHomeView(viewModel: viewModel)
  }
}
