import Foundation
import UIKit

class DetailsMenuViewModel: UIViewController {
    
    @IBOutlet var rootView: DetailsMenuView!
        
    var pokemon: Pokemon?
    
    let networkManager = NetworkManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.decorate()
        networkManager.fetchPokemonDetails(api: pokemon?.url ?? "", completionHandler: { [weak self] result in
            switch result {
            case .success(let pokemon):
                self?.rootView.pokemonNameLabel.text = pokemon.name?.capitalized
                self?.rootView.pokemonHeightLabel.text = "\(pokemon.height! * 10)cm".capitalized
                self?.rootView.pokemonWeightLabel.text = "\(pokemon.weight! / 10)kg".capitalized
                self?.rootView.pokemonTypeLabel.text = "\(pokemon.types?.first?.type.name ?? "nil")".capitalized
                self?.networkManager.getImage(from: pokemon.sprites?.frontImage ?? "", completionHandler: { result in
                    switch result {
                    case .success(let image):
                        self?.rootView.pokemonImage.image = image
                    case .failure(let error):
                        let errorMessage = [error.failureReason, error.recoverySuggestion].compactMap({ $0 }).joined(separator: ". ")
                        let alertVC = UIAlertController(title: error.errorDescription, message: errorMessage, preferredStyle: .alert)
                        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
                        self!.present(alertVC, animated: true, completion: nil)
                    }
                })
            case .failure(let error):
                let errorMessage = [error.failureReason, error.recoverySuggestion].compactMap({ $0 }).joined(separator: ". ")
                let alertVC = UIAlertController(title: error.errorDescription, message: errorMessage, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .default))
                self!.present(alertVC, animated: true, completion: nil)
            }
        })
        
    }
    
}

