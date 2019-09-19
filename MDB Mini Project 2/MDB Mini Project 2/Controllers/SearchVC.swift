//
//  ViewController.swift
//  MDB Mini Project 2
//
//  Created by Anik Gupta on 9/17/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit


class SearchVC: UIViewController{
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var pokemonList = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    static var filter = Filter()
    static var randomTwenty = false
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pokémon"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.rowHeight = 50
        
        // Init pokemon list and sort based on number
        pokemonList = PokemonGenerator.getPokemonArray()
        pokemonList.sort { (a, b) -> Bool in
            return a.number - b.number < 0
        }
        updateFilter()
    }
    override func viewWillAppear(_ animated: Bool) {
        updateFilter()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func filterContentForSearchText(_ searchText: String){
        // filters based on search text and filter
        filteredPokemon = pokemonList.filter({( pokemon : Pokemon) -> Bool in
            return SearchVC.filter.isValid(pokemon: pokemon) && (searchText == "" || pokemon.name.lowercased().contains(searchText.lowercased()) || String(pokemon.number).contains(searchText.lowercased()))
        })
        // Selects 20 random filtered pokemon if option is selected
        if SearchVC.randomTwenty {
            filteredPokemon.shuffle()
            filteredPokemon = Array(filteredPokemon.prefix(min(filteredPokemon.count, 20)))
            filteredPokemon.sort { (a, b) -> Bool in
                return a.number - b.number < 0
            }
        }
        tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    // Sets filter from FiltersVC
    static func setFilter(f: Filter) {
        SearchVC.filter = f
        
    }
    func updateFilter(){
        filteredPokemon = pokemonList.filter({( pokemon : Pokemon) -> Bool in
            return SearchVC.filter.isValid(pokemon: pokemon)
        })
        if SearchVC.randomTwenty {
            filteredPokemon.shuffle()
            filteredPokemon = Array(filteredPokemon.prefix(min(filteredPokemon.count, 20)))
            filteredPokemon.sort { (a, b) -> Bool in
                return a.number - b.number < 0
            }
        }
        tableView.reloadData()
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue to detailed view
        if segue.identifier != "showFilters" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let pokemon: Pokemon
                pokemon = filteredPokemon[indexPath.row]
                let controller =  segue.destination as! DetailVC
                controller.detailPokemon = pokemon
            }
        }
    }
}
extension SearchVC: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}

extension SearchVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

extension SearchVC: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
extension SearchVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemon.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let pokemon: Pokemon
        pokemon = filteredPokemon[indexPath.row]
        // Get data about pokemon and display if possible in row
        cell.textLabel!.text = String(pokemon.name)
        cell.detailTextLabel!.text = String(pokemon.number)
        guard let url = URL(string: pokemon.imageUrl)?.absoluteString else {
            return cell
        }
        do {
            let data = try Data(contentsOf: URL(string: pokemon.imageUrl)!)
        } catch {
            return cell
        }
        cell.imageView!.image = UIImage(data: try! Data(contentsOf: URL(string: pokemon.imageUrl)!))
        return cell
    }
}
