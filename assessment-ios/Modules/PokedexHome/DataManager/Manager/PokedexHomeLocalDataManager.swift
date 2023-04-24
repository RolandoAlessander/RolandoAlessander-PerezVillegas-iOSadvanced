//
//  PokedexHomeLocalDataManager.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation
import CoreData
import Combine

protocol PokedexHomeLocalDataManagerProtocol {
  func savePokemonsModelIfNeeded(model: [PokemonModel], offset: Int) -> AnyPublisher<Bool, Never>
  func getLocalPokemonsData(offset: Int) -> AnyPublisher<[PokemonModel], Error>
}

final class PokedexHomeLocalDataManager: PokedexHomeLocalDataManagerProtocol {

  let container: NSPersistentContainer

  init() {
    container = NSPersistentContainer(name: "assessment_ios")
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Container load failed: \(error)")
      }
    }
  }

  func savePokemonsModelIfNeeded(model: [PokemonModel], offset: Int)  -> AnyPublisher<Bool, Never> {

    for (index, pokemon) in model.enumerated() {
      let newPokemons = PokedexModel(context: container.viewContext)
      newPokemons.offset = Int16(offset + index)
      newPokemons.name = pokemon.name
    }

    do {
      try container.viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }

    return Just(true)
      .eraseToAnyPublisher()
  }

  func getLocalPokemonsData(offset: Int) -> AnyPublisher<[PokemonModel], Error> {
    Future { promise in
      var pokemons: [PokedexModel]? = nil
      let fetchRequest : NSFetchRequest<PokedexModel> = PokedexModel.fetchRequest()
      var pokemonsModel: [PokemonModel] = []
      fetchRequest.predicate = NSPredicate.init(format: "offset <= %d && offset >= %d", offset + 10, offset)
      do {
        pokemons = try self.container.viewContext.fetch(PokedexModel.fetchRequest())
        pokemons?.forEach {
          pokemonsModel.append(PokemonModel(name: $0.name ?? "", image: ""))
        }
        promise(.success(pokemonsModel))
      } catch {
        promise(.failure(LocalStorageError.couldNotLoadData))
      }
    }.eraseToAnyPublisher()
  }
}

enum LocalStorageError: Error {
  case couldNotLoadData
}

