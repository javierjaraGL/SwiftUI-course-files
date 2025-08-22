
//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Javier Jara Montoya on 4/8/25.
//
import SwiftUI
import MapKit

struct ApexPredator: Decodable {
    let id: Int
    let name: String
    let type: APType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        return name.lowercased().replacingOccurrences(of: " ", with: "")
    }

    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension ApexPredator: Identifiable {
    
}

struct MovieScene: Decodable, Identifiable {
    let id: Int
    let movie: String
    let sceneDescription: String
}

enum APType: String, Decodable, CaseIterable, Identifiable {
    case all
    case land
    case air
    case sea
    
    var id: APType {
        self
    }

    var background: Color {
        switch self {
        case .air:
                .brown
        case .land:
                .teal
        case .sea:
                .blue
        default:
                .black
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            "square.stack.3d.up.fill"
        case .land:
            "leaf.fill"
        case .air:
            "wind"
        case .sea:
            "drop.fill"
        }
    }
}
