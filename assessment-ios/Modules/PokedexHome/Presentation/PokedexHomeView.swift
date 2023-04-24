//
//  ContentView.swift
//  assessment-ios
//
//  Created by Ivan Trejo on 15/04/23.
//

import SwiftUI
import CoreData

struct PokedexHomeView<ViewModel: PokedexHomeViewModelProtocol>: View {

  @ObservedObject var viewModel: ViewModel

  init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    ZStack(alignment: .center) {
      NavigationView {
        content
      }
      .onAppear(perform: {
        viewModel.getPokemons()
      })
      VStack {
        Text("Version: \(Util.version())")
          .padding()
          .font(.footnote)
          .multilineTextAlignment(.center)
          .frame(height: 25.0, alignment: .center)
      }
      .frame(
        maxWidth: .infinity,
        maxHeight: .infinity,
        alignment: .bottom
      )
    }

  }

  private var content: some View {
    switch viewModel.state {
    case .loading: return AnyView(Loader())
    case .error, .empty: return AnyView(ErrorView())
    case .onComplete: return AnyView(pokemonsContent)
    }
  }

  var pokemonsContent: some View {
    List {
      ForEach(viewModel.pokemonsList ?? []) { pokemon in
        NavigationLink {
          PokemonDetailRouter.createPokemonDetailView(pokemonName: pokemon.name)
        } label: {
          PokedexCellView(model: pokemon, id: viewModel.getPokemonIndex(pokemon: pokemon))
        }
      }
      if viewModel.isNotLast() {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle())
          .onAppear(perform: {
            viewModel.getPokemons()
          })
      }
    }
  }
}
