//
//  PokemonCellView.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import SwiftUI

struct PokedexCellView: View {
  var model: PokemonModel
  var id: Int

  var body: some View {
    HStack {
      AsyncImage(
        url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
      )
      .frame(width: 75, height: 75)
      .clipShape(Circle())
      .foregroundColor(Color.gray.opacity(0.60))
      .scaledToFit()

      VStack {
        Text(model.name)
      }
    }
  }
}
