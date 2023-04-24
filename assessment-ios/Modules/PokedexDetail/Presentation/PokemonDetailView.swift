//
//  PokemonDetailView.swift
//  assessment-ios
//
//  Created by Rolando Alessander on 24/04/23.
//

import SwiftUI

struct PokemonDetailView<ViewModel: PokemonDetailViewModelProtocol>: View {

  @ObservedObject var viewModel: ViewModel

  init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }

  var body: some View {
    ZStack(alignment: .top) {
      Color.white
      content
    }
  }

  private var content: some View {
    switch viewModel.state {
    case .loading: return AnyView(Loader())
    case .error, .empty: return AnyView(ErrorView())
    case .onComplete: return AnyView(pokemonDetailContent)
    }
  }

  var pokemonDetailContent: some View {
    VStack {
      AsyncImage(url: URL(string: viewModel.pokemonDetail?.sprites.image ?? "")) { image in
        if let image = image {
          image
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 250)
        }
      } placeholder: {
        ProgressView()
          .frame(width: 150, height: 150)
      }

      Text(viewModel.pokemonDetail?.name.capitalized ?? "")
        .font(.largeTitle)

      HStack {
        ForEach(viewModel.pokemonDetail?.types ?? []) { type in
          Text(type.type.name)
            .font(.subheadline).bold()
            .foregroundColor(.white)
            .padding(.init(top: 8, leading: 24, bottom: 8, trailing: 24))
            .cornerRadius(20)
            .background {
              Rectangle()
                .foregroundColor(.black)
                .cornerRadius(10)
            }
        }
      }.padding()

      HStack {
        Text("Height: \(viewModel.pokemonDetail?.height ?? 0)")
        Text("Weight: \(viewModel.pokemonDetail?.weight ?? 0)")
      }
      .padding()
    }
  }
}
