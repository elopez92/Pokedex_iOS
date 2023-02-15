//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Eduardo Lopez on 1/29/23.
//

import Foundation

struct PokemonPage: Codable {
    var count: Int?
    var next: String?
    var previous: String? = nil
    var results: [Pokemon]?
    
    
    enum CodingKeys: String, CodingKey {
        
        case count    = "count"
        case next     = "next"
        case previous = "previous"
        case results  = "results"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        count    = try values.decodeIfPresent(Int.self       , forKey: .count    )
        next     = try values.decodeIfPresent(String.self    , forKey: .next     )
        previous = try values.decodeIfPresent(String.self    , forKey: .previous )
        results  = try values.decodeIfPresent([Pokemon].self , forKey: .results  )
        
    }
}
struct Pokemon: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String
    
    static var samplePokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}

struct DetailPokemon: Codable{
    let id: Int
    let height: Int
    let weight: Int
}
