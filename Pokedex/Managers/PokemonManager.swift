//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Eduardo Lopez on 1/29/23.
//

import Foundation

class PokemonManager {
    func getPokemon() -> [Pokemon]{
        let data: PokemonPage = Bundle.main.decode(file: "pokemon.json")
        let pokemon: [Pokemon] = data.results!
        
        return pokemon
    }
    
    func getOnlinePokemon(_ completion:@escaping ([Pokemon]) -> ()){
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=2000", model: PokemonPage.self) { data in
            print(data)
            completion(data.results!)
        } failure: { error in
            print(error)
        }
    }
    
    func getDetailedPokemon(id: Int, _ completion:@escaping (DetailPokemon) -> ()){
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)/", model: DetailPokemon.self) { data in
            completion(data)
        } failure: { error in
            print(error)
        }
    }
    
    func getPokemonList(limit: Int, offset: Int, _ completion:@escaping (PokemonPage) -> ()){
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/?offset=\(offset)&limit=\(limit)", model: PokemonPage.self) { data in
            print("https://pokeapi.co/api/v2/pokemon/?offset=\(offset)&limit=\(limit)")
            completion(data)
        } failure: { error in
            print(error)
        }
    }
}
