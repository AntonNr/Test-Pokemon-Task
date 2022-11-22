import XCTest
@testable import Test_Pokemon_Task

class TestPokemonTaskTests: XCTestCase {
    
    var networkManager: NetworkManager!

    override func setUpWithError() throws {
        networkManager = NetworkManager()
    }

    override func tearDownWithError() throws {
        networkManager = nil
        try super.tearDownWithError()
    }

    func testFetchPokemonArray() throws {
        var pokemonArray = PokemonArray()
        
        networkManager.fetchPokemonArray(completionHandler: { result in
            switch result {
            case .success(let pokemons):
                pokemonArray = pokemons
                XCTAssertEqual(pokemonArray.results?.count, 20, "Check count of Pokemon received")
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func testFetchPokemonDetails() throws {
        var pokemonObject = Pokemon()
        var status: Bool = false
        let api: String = "https://pokeapi.co/api/v2/pokemon/1/"

        networkManager.fetchPokemonDetails(api: api, completionHandler: { result in
            switch result {
            case .success(let pokemon):
                pokemonObject = pokemon
                status = true
                XCTAssert(status, "Сheck the status of getting Pokemon data")
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func testGetImage() throws {
        var pokemonImage = UIImage()
        var status: Bool = false
        let url: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
        
        networkManager.getImage(from: url, completionHandler: { result in
            switch result {
            case .success(let image):
                pokemonImage = image
                status = true
                XCTAssert(status, "Сheck the status of getting Pokemon image")
            case .failure(let error):
                print(error)
            }
            
        })
    }

}
