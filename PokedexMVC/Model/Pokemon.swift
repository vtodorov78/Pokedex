//
//  Pokemon.swift
//  PokedexMVC
//
//  Created by Vladimir Todorov on 26.05.21.
//

import UIKit

class Pokemon: Codable {
    
    let name: String?
    let imageUrl: String?
    let description: String?
    let height: Int?
    let weight: Int?
    let attack: Int?
    let defense: Int?       
    let type: String?
    let evolutionChain: [EvolutionChain]?
}

class EvolutionChain: Codable {
    let id: String?
    let name: String?
}
