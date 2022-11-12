import Foundation
import UIKit

class DetailsMenuView: UIView {
    
    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var pokemonNameLabel: UILabel!
    @IBOutlet var pokemonHeightLabel: UILabel!
    @IBOutlet var pokemonWeightLabel: UILabel!
    @IBOutlet var pokemonTypeLabel: UILabel!
        
    func decorate() {
        pokemonNameLabel.font = pokemonNameLabel.font.withSize(25)
        pokemonHeightLabel.font = pokemonHeightLabel.font.withSize(25)
        pokemonWeightLabel.font = pokemonWeightLabel.font.withSize(25)
        pokemonTypeLabel.font = pokemonTypeLabel.font.withSize(25)
    }
    
}
