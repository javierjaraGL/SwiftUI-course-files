//
//  FetchService.swift
//  BBQuotes
//
//  Created by Javier Jara Montoya on 12/8/25.
//

import Foundation

struct FetchService {
    private enum FetchError: Error {
        case badResponse
    }

    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote {
        // Build fetch url
        let quoteURL = baseURL.appending(path: "quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        // Decode data
        
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        // Return quote
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Char {
        // Build fetch url
        let charURL = baseURL.appending(path: "characters")
        let fetchURL = charURL.appending(queryItems: [URLQueryItem(name: "name", value: name)])
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let chars = try decoder.decode([Char].self, from: data)
        // Return quote
        return chars.first!
    }
    
    func fetchDeath(for character: String) async throws ->  Death? {
        let deathURL = baseURL.appending(path: "deaths")
        
        let (data, response) = try await URLSession.shared.data(from: deathURL)
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let deaths = try decoder.decode([Death].self, from: data)
        
        // Return quote
        return deaths.filter{ $0.character == character}.first
    }
    
    
    func fetchEpisode(from show: String) async throws -> Episode? {
        // Build fetch url
        let episodeURL = baseURL.appending(path: "episodes")
        let fetchURL = episodeURL.appending(queryItems:
                                                [URLQueryItem(name: "production", value: show)])
        // Fetch data
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        // Handle response
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
        
        // Decode data
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let episodes = try decoder.decode([Episode].self, from: data)
        // Return quote
        return episodes.randomElement()
    }
}
