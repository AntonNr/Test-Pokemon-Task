import Foundation

struct Pokemon: Codable {
    var name: String?
    var height: Int?
    var weight: Double?
    var types: [Types]?
    var sprites: PokemonImage?
    var url: String?
}

struct Types: Codable {
    var type: TypeOfPokemon
}

struct PokemonImage: Codable {
    var frontImage: String = ""
    
    enum CodingKeys: String, CodingKey {
        case frontImage = "front_default"
    }
}

struct TypeOfPokemon: Codable {
    var name: String?
    var url: String?
}

struct PokemonArray: Codable {
    var results: [Pokemon]?
}
