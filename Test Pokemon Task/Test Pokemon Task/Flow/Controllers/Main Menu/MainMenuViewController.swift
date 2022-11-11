import UIKit

class MainMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var pokemonTableView: UITableView!
    
    var mainMenuViewModel = MainMenuViewModel()
    var pokemon: PokemonArray?
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        mainMenuViewModel.loadPokemons()
        mainMenuViewModel.pokemon = { [weak self] results in
            self?.pokemon = results
            self?.pokemonTableView.reloadData()
        }
            
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon?.results?.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MainMenuTableViewCell", for: indexPath) as? MainMenuTableViewCell {
                
            cell.pokemonNameLabel.text = pokemon?.results?[indexPath.row].name.capitalized
                
            return cell
        }
            
        return UITableViewCell()
    }

}

