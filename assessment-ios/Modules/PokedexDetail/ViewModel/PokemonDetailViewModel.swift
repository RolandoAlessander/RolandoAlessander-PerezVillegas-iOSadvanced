//
//  PokemonDetailViewModel.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation
import Combine

protocol PokemonDetailViewModelProtocol: ObservableObject {
  var pokemonDetail: PokemonDetail? { get set }
  var state: ViewState { get set }
}

final class PokemonDetailViewModel: PokemonDetailViewModelProtocol {

  private let repository: PokemonDetailRepositoryProtocol
  private let name: String
  private var cancellables: Set<AnyCancellable> = []
  @Published var state: ViewState
  @Published var pokemonDetail: PokemonDetail?

  init(repository: PokemonDetailRepositoryProtocol, name: String) {
    self.repository = repository
    self.name = name
    self.state = .loading
    self.getPokemons()
  }

  private func getPokemons() {
    repository.getPokemonDetail(name: name)
      .sink { [weak self] value in
        switch value {
        case .failure(let error):
          self?.state = .error(error)
        case .finished:
          self?.state = .onComplete
        }
      } receiveValue: { [weak self] model in
        self?.pokemonDetail = model
      }
      .store(in: &cancellables)
  }
}
