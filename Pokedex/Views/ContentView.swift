//
//  ContentView.swift
//  Pokedex
//
//  Created by Eduardo Lopez on 1/29/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                    ForEach(vm.filteredPokemon) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon))
                        {
                            PokemonView(pokemon: pokemon)
                        }
                        .onAppear{
                            if(vm.pokemonList.firstIndex(of: pokemon) ?? 0 >= vm.pokemonList.count - 1 && !vm.endReached && !vm.isLoading && !vm.isSearching){
                                vm.loadPokemonPaginated()
                            }
                        }
                    }
                }
            }
            .animation(.easeIn(duration: 0.3), value: vm.filteredPokemon.count)
            .navigationTitle("Pokedex")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $vm.searchText)
        .environmentObject(vm)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
