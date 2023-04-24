//
//  PokedexHomeModel.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation

struct PokemonsModel: Codable {
  var count: Int
  var next: String
  var pokemons: [PokemonModel]

  private enum CodingKeys: String, CodingKey {
    case count
    case next
    case pokemons = "results"
  }
}

struct PokemonModel: Codable, Identifiable, Equatable {
  let id: UUID = UUID()
  var name: String
  var image: String

  private enum CodingKeys: String, CodingKey {
    case name
    case image = "url"
  }
}
