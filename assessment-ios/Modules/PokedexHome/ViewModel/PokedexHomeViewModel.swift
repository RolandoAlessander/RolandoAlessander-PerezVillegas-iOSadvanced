//
//  PokedexHomeViewModel.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation
import Combine

protocol PokedexHomeViewModelProtocol: ObservableObject {
  var pokemonsList: [PokemonModel]? { get set }
  var state: ViewState { get set }

  func getPokemonIndex(pokemon: PokemonModel) -> Int
  func getPokemons()
  func isNotLast() -> Bool
}

final class PokedexHomeViewModel: PokedexHomeViewModelProtocol {
  private let repository: PokedexHomeRepositoryProtocol
  private var cancellables: Set<AnyCancellable> = []
  private var offset: Int = 0

  @Published var pokemonsList: [PokemonModel]?
  @Published var state: ViewState

  init(repository: PokedexHomeRepositoryProtocol) {
    self.repository = repository
    self.state = .loading
  }

  func getPokemons() {
    repository.getPokemons(offset: offset)
      .sink { [weak self] value in
        switch value {
        case .failure(let error):
          self?.state = .error(error)
        case .finished:
          self?.state = .onComplete
          self?.offset += 10
        }
      } receiveValue: { [weak self] model in
        guard let _ = self?.pokemonsList else {
          self?.pokemonsList = model
          return
        }
        self?.pokemonsList?.append(contentsOf: model)
      }
      .store(in: &cancellables)
  }

  func getPokemonIndex(pokemon: PokemonModel) -> Int {
    if let index = self.pokemonsList?.firstIndex(of: pokemon) {
      return index + 1
    }
    return 0
  }

  func isNotLast() -> Bool {
    return offset < 200
  }
}

