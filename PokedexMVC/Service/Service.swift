//
//  Service.swift
//  PokedexMVC
//
//  Created by Vladimir Todorov on 26.05.21.
//

import UIKit

class Service {
    
    static let shared = Service()
    let BASE_URL = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    
    func fetchPokemon(completion: @escaping ([Pokemon]) -> ()) {
        
        guard let url = URL(string: BASE_URL) else { return }
          
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // handle error
            if let error = error {
                print("Failed to fetch data with error: ", error.localizedDescription)
                return
            }
            
            guard let data = data?.parseData(removeString: "null,") else { return }
            
            
            do {
                let pokemonArray = try JSONDecoder().decode([Pokemon].self, from: data)
                completion(pokemonArray)
                
            } catch let error {
                print("Failed to create JSON with error: ", error.localizedDescription)
            }
        }
        task.resume()
    }
}
