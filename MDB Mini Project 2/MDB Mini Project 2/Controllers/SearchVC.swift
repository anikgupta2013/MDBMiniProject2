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
    
    //var detailViewController: DetailVC? = nil
    var pokemonList = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pokémon"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 50
        
        pokemonList = PokemonGenerator.getPokemonArray()
        pokemonList.sort { (a, b) -> Bool in
            return a.number - b.number < 0
        }
        /*if let splitViewController = splitViewController {
            let controllers = splitViewController.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailVC
        }*/
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        /*guard let splVCTest = splitViewController else{
            return
        }*/
        if splitViewController!.isCollapsed {
            if let selectionIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectionIndexPath, animated: animated)
            }
        }
        super.viewWillAppear(animated)
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View

    
    
    
    // MARK: - Private instance methods
    
    func filterContentForSearchText(_ searchText: String){//}, scope: String = "All") {
        filteredPokemon = pokemonList.filter({( pokemon : Pokemon) -> Bool in
            //let doesCategoryMatch = (scope == "All") || (pokemon.name == scope)
            
            /*if searchBarIsEmpty() {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && pokemon.name.lowercased().contains(searchText.lowercased())
            }*/
            return pokemon.name.lowercased().contains(searchText.lowercased()) || String(pokemon.number).contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //print(segue)
        if segue.identifier != "showFilters" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let pokemon: Pokemon
                if isFiltering() {
                    pokemon = filteredPokemon[indexPath.row]
                } else {
                    pokemon = pokemonList[indexPath.row]
                }
                //let controller = (segue.destination as! UINavigationController).topViewController as! DetailVC
                let controller =  segue.destination as! DetailVC
                controller.detailPokemon = pokemon
            }
        }
    }
}
extension SearchVC: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)//, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

extension SearchVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        //let scope = "All"//searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!)//, scope: scope)
    }
}

extension SearchVC: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
extension SearchVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            //searchFooter.setIsFilteringToShow(filteredItemCount: filteredPokemon.count, of: pokemonList.count)
            return filteredPokemon.count
        }
        //searchFooter.setNotFiltering()
        return pokemonList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("hi")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let pokemon: Pokemon
        if isFiltering() {
            pokemon = filteredPokemon[indexPath.row]
        } else {
            pokemon = pokemonList[indexPath.row]
        }
        
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
