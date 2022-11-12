import Foundation
import UIKit

class MainMenuView: UIView {
    
    @IBOutlet var pokemonTableView: UITableView!
    @IBOutlet var pokemonImageView: UIImageView!
       
    func decorate() {
           
        pokemonImageView.image = UIImage(named: "Pokemon_logo")
           
    }
    
}
