//
//  PokemonDetailModel.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import Foundation

struct PokemonDetail: Codable {
  let id: Int
  var name: String
  var abilities: [PokemonAbilityInformation]
  var sprites: PokemonSprites
  var height: Int
  var weight: Int
  var types: [PokemonTypes]
}

struct PokemonSprites: Codable {
  let image: String?

  private enum CodingKeys: String, CodingKey {
    case image = "front_default"
  }
}

struct PokemonAbilityInformation: Codable {
  let is_hidden: Bool
  let slot: Int
  let ability: PokemonAbility
}

struct PokemonAbility: Codable {
  let name: String
  let url: String
}

struct PokemonTypes: Codable, Identifiable {
  let id: UUID = UUID()
  var slot: Int
  var type: PokemonType

  private enum CodingKeys: String, CodingKey {
    case slot
    case type
  }
}

struct PokemonType: Codable {
  var name: String
  var url: String
}
