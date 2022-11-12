import Foundation
import UIKit

class DetailsMenuViewModel {
    
    var pokemon: Pokemon?
        var pokemonDetails: ((Pokemon) -> Void)?
        
        func loadPokemonInformation() {
            let urlString: String = pokemon?.url ?? ""
            if let url = URL(string: urlString) {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { [weak self] request, data, error in
                    if let data = data {
                        if let result: Pokemon = try? JSONDecoder().decode(Pokemon.self, from: data){
                            
                            if (result.name == nil) {
                                print("Result is nil")
                            } else {
                                self?.pokemonDetails?(result)
                            }
                            
                        }
                    }
                    
                    if error != nil {
                        print("ERROR!")
                    }
                    
                }
                
            }
        }
        
        func getImage(from string: String) -> UIImage? {
            guard let url = URL(string: string)
                else {
                    print("Unable to create URL")
                    return nil
            }

            var image: UIImage? = nil
            do {
                let data = try Data(contentsOf: url, options: [])

                image = UIImage(data: data)
            }
            catch {
                print(error.localizedDescription)
            }
            return image
        }
    
}
