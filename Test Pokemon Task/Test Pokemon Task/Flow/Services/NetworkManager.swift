import Foundation
import UIKit

enum NetworkErrors: Error {
    case urlError
    case responseError
    case serverError
    case internetError
}

class NetworkManager {    
    let api = "https://pokeapi.co/api/v2/pokemon"
    
    func fetchPokemonArray(completionHandler: @escaping (Result<PokemonArray, NetworkErrors>) -> Void) {
        guard let url = URL(string: api) else {
            completionHandler(.failure(NetworkErrors.urlError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data,
               let pokemonSummary = try? JSONDecoder().decode(PokemonArray.self, from: data) {
                DispatchQueue.main.async {
                    completionHandler(.success(pokemonSummary))
                }
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(NetworkErrors.responseError))
                return
            }
            
            if error != nil {
                completionHandler(.failure(NetworkErrors.serverError))
                return
            }
        })
        task.resume()
    }
    
    func fetchPokemonDetails(api: String, completionHandler: @escaping (Result<Pokemon, NetworkErrors>) -> Void) {
        guard let url = URL(string: api) else {
            completionHandler(.failure(NetworkErrors.urlError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data,
               let pokemonSummary = try? JSONDecoder().decode(Pokemon.self, from: data) {
                DispatchQueue.main.async {
                    completionHandler(.success(pokemonSummary))
                }
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(NetworkErrors.responseError))
                return
            }
            
            if error != nil {
                completionHandler(.failure(NetworkErrors.serverError))
                return
            }
        })
        task.resume()
    }
    
    func getImage(from string: String, completionHandler: @escaping (Result<UIImage, NetworkErrors>) -> Void) {
        guard let url = URL(string: string) else {
            completionHandler(.failure(NetworkErrors.urlError))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    completionHandler(.success(image))
                }
            }
            
            if error != nil {
                completionHandler(.failure(NetworkErrors.serverError))
                return
            }
        }
        dataTask.resume()
    }

}

protocol LocalizedError : Error {
    var errorDescription: String? { get }
    var failureReason: String? { get }
    var recoverySuggestion: String? { get }
}

extension NetworkErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serverError:
            return "Server Error"
        case .responseError:
            return "Response Error"
        case .urlError:
            return "Error with URL"
        case .internetError:
            return "No Internet Connection"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .serverError, .responseError:
            return "Something went wrong"
        case .internetError, .urlError:
            return nil
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .serverError, .responseError, .urlError:
            return "Please, try again later"
        case .internetError:
            return "Please check your internet connection and try again"
        }
    }
}
