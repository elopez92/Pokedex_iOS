//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Eduardo Lopez on 1/29/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @EnvironmentObject var vm: ViewModel
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            PokemonView(pokemon: pokemon)
            
            VStack(spacing: 10) {
                Text("**ID**: \(vm.pokemonDetails?.id ?? 0)")
                Text("**Weight**: \(vm.formHW(value: vm.pokemonDetails?.weight ?? 0)) KG")
                Text("**Height**: \(vm.formHW(value: vm.pokemonDetails?.height ?? 0)) M")
            }
        }
        .onAppear{
            vm.getDetails(pokemon: pokemon)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: Pokemon.samplePokemon)
            .environmentObject(ViewModel())
    }
}
