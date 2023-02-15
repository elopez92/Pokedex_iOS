//
//  ViewModel.swift
//  Pokedex
//
//  Created by Eduardo Lopez on 1/29/23.
//

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    private let pokemonManager = PokemonManager()
    
    private var curPage = 0
    private let PAGE_SIZE = 20
    
    @Published var pokemonList = [Pokemon]()
    @Published var pokemonDetails: DetailPokemon?
    @Published var searchText = ""
    
    @Published var endReached = false
    @Published var isSearching = false
    @Published var isLoading = false
    
    var filteredPokemon: [Pokemon] {
        return searchText == "" ? pokemonList : pokemonList.filter{
            $0.name.contains(searchText.lowercased())
        }
    }
    
    init() {
        loadPokemonPaginated()
    }
    
    func getPokemonList() {
        pokemonManager.getOnlinePokemon() { data in
            DispatchQueue.main.async {
                self.pokemonList = data
            }
        }
    }
    
    func loadPokemonPaginated() {
        self.isLoading = true
        pokemonManager.getPokemonList(limit: self.PAGE_SIZE, offset: self.curPage * self.PAGE_SIZE) { data in
            DispatchQueue.main.async {
                self.endReached = self.curPage * self.PAGE_SIZE >= data.count ?? 0
                self.pokemonList += data.results!
                self.isLoading = false
                self.curPage += 1
            }
            
        }
    }
    
    func getPokemonIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon) {
            return index + 1
        }
        return 0
    }
    
    func getDetails(pokemon: Pokemon) {
        let id = getPokemonIndex(pokemon: pokemon)
        
        self.pokemonDetails = DetailPokemon(id: 0, height: 0, weight: 0)
        
        pokemonManager.getDetailedPokemon(id: id) { data in
            DispatchQueue.main.async {
                self.pokemonDetails = data
            }
        }
    }
    
    func formHW(value: Int) -> String {
        let dValue = Double(value)
        let string = String(format: "%.2f", dValue / 2)
        
        return string
    }
}
