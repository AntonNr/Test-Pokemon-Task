import Foundation
import UIKit

class DetailsMenuViewController: UIViewController {
    
    @IBOutlet var rootView: DetailsMenuView!
        
    var detailsMenuViewModel = DetailsMenuViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        rootView.decorate()
        detailsMenuViewModel.loadPokemonInformation()
        detailsMenuViewModel.pokemonDetails = { [weak self] result in
            self?.rootView.pokemonNameLabel.text = result.name?.capitalized
            self?.rootView.pokemonHeightLabel.text = "\(result.height!)cm".capitalized
            self?.rootView.pokemonWeightLabel.text = "\(result.weight!)kg".capitalized
            self?.rootView.pokemonTypeLabel.text = "\(result.types?.first?.type.name ?? "nil")".capitalized
            if let image = self?.detailsMenuViewModel.getImage(from: result.sprites?.frontImage ?? "nil") {
                self?.rootView.pokemonImage.image = image
            }
                    
        }
    }
    
}
