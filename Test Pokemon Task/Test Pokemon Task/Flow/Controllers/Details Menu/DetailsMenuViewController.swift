import Foundation
import UIKit

class DetailsMenuViewController: UIViewController {
    
    @IBOutlet var rootView: DetailsMenuView!
        
    var detailsMenuViewModel = DetailsMenuViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        rootView.decorate()
        detailsMenuViewModel.fetchPokemonDetails()
        detailsMenuViewModel.pokemonDetails = { [weak self] result in
            self?.rootView.pokemonNameLabel.text = result.name?.capitalized
            self?.rootView.pokemonHeightLabel.text = "\(result.height! * 10)cm".capitalized
            self?.rootView.pokemonWeightLabel.text = "\(result.weight! / 10)kg".capitalized
            self?.rootView.pokemonTypeLabel.text = "\(result.types?.first?.type.name ?? "nil")".capitalized
            if let image = self?.detailsMenuViewModel.getImage(from: result.sprites?.frontImage ?? "") {
                self?.rootView.pokemonImage.image = image
            }
        }
        
        detailsMenuViewModel.showAlert = { text in
            let alert = UIAlertController(title: text, message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
}
