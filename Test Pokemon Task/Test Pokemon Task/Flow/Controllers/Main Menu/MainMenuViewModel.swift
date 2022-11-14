import Foundation

class MainMenuViewModel {
    var getPokemons: ((PokemonArray) -> Void)?
    var showAlert: ((String) -> Void)?
            
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
                            self?.showAlert?("Data not loading error")
                        } else {
                            self?.getPokemons?(result)
                        }
                    }
                }
                if let error = error {
                    self?.showAlert?(error.localizedDescription)
                }
            }
                
        }
    }
    
}
