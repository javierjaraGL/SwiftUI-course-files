//
//  Predators.swift
//  JPApexPredators
//
//  Created by Javier Jara Montoya on 4/8/25.
//

import Foundation

class Predators {
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }

    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                #warning("reivew this strategy")
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            }
            catch {
             print("error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        guard searchTerm.isEmpty else {
            return apexPredators.filter{
                $0.name.localizedStandardContains(searchTerm)
            }
        }
        return apexPredators
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort {
            alphabetical ? $0.name < $1.name : $0.id < $1.id
        }
    }
    
    func filter(by type: APType) {
        guard type != .all else {
            apexPredators = allApexPredators
            return
        }
        apexPredators = allApexPredators.filter {
            $0.type == type
        }
    }
}
