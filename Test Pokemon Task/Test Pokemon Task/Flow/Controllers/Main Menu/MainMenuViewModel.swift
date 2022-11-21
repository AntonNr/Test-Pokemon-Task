import UIKit

class MainMenuViewModel: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var rootView: MainMenuView!
    
    var pokemonArray: PokemonArray?
    
    let networkManager = NetworkManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.decorate()
        networkManager.fetchPokemonArray { [weak self] result in
            switch result {
            case .success(let pokemons):
                self?.pokemonArray = pokemons
            case .failure(let error):
                let errorMessage = [error.failureReason, error.recoverySuggestion].compactMap({ $0 }).joined(separator: ". ")
                let alertVC = UIAlertController( title: error.errorDescription, message: errorMessage, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .default))
                self!.present(alertVC, animated: true, completion: nil)
            }
            
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
            
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsVC: DetailsMenuViewModel = storyboard.instantiateViewController(withIdentifier: "DetailsMenuViewModel") as? DetailsMenuViewModel {
                
            detailsVC.pokemon = pokemonArray?.results?[indexPath.row]
            
        self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }

}

