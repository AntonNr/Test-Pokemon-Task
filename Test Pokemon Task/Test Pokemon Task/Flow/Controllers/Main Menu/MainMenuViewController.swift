import UIKit

class MainMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var rootView: MainMenuView!
        
    var mainMenuViewModel = MainMenuViewModel()
    var pokemonArray: PokemonArray?
        
    override func viewDidLoad() {
        super.viewDidLoad()
            
        rootView.decorate()
        mainMenuViewModel.loadPokemonsArray()
        mainMenuViewModel.pokemons = { [weak self] results in
            self?.pokemonArray = results
            self?.rootView.pokemonTableView.reloadData()
        }
                
        rootView.pokemonTableView.delegate = self
        rootView.pokemonTableView.dataSource = self
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray?.results?.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MainMenuTableViewCell", for: indexPath) as? MainMenuTableViewCell {
                
            cell.pokemonNameLabel.text = pokemonArray?.results?[indexPath.row].name?.capitalized
            cell.backgroundColor = rootView.backgroundColor
            
            return cell
        }
                
        return UITableViewCell()
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            
        let detailsPokemon = DetailsMenuViewModel()
        detailsPokemon.pokemon = pokemonArray?.results?[indexPath.row]
            
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsVC: DetailsMenuViewController = storyboard.instantiateViewController(withIdentifier: "DetailsMenuViewController") as? DetailsMenuViewController {
                
        detailsVC.detailsMenuViewModel = detailsPokemon
            
        self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }


}

