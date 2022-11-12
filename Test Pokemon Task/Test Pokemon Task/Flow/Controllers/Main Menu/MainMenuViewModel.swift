import Foundation

class MainMenuViewModel {
    
    var showErrorAlert: ((String) -> Void)?
    var pokemons: ((PokemonArray) -> Void)?
    var pokemonCount: Int?
            
    func loadPokemonsArray() {
        let urlString: String = "https://pokeapi.co/api/v2/pokemon"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
                    
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {
                [weak self] request, data, error in
                if let data = data {
                    if let result: PokemonArray = try? JSONDecoder().decode(PokemonArray.self, from: data) {
                            
                        if (result.results == nil) {
                            print("Result is nil")
                        } else {
                            self?.pokemons?(result)
                            self?.pokemonCount = result.results?.count
                        }
                            
                    }
                }
                        
                if error != nil {
                    print("ERROR!")
                }
                    
            }
                
        }
    }
    
}
