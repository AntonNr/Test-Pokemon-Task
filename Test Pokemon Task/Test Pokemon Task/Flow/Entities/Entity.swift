import Foundation

struct Pokemon: Codable {
    var name: String = ""
    var url: String = ""
}

struct PokemonArray: Codable {
    var results: [Pokemon]?
}
