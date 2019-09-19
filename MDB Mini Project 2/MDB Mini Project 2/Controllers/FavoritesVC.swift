//
//  FavoritesVC.swift
//  MDB Mini Project 2
//
//  Created by Anik Gupta on 9/19/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var pokemonList = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        
        update()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        update()
    }
    func update(){
        // Read pokemon list from UserDefaults --> added from DetailVC
        let defaults = UserDefaults.standard
        var arr = defaults.array(forKey: "savedPokemon") as? [String] ?? [String]()
        pokemonList = PokemonGenerator.getPokemonArray().filter({( pokemon : Pokemon) -> Bool in
            return arr.contains(pokemon.name)
        })
        pokemonList.sort { (a, b) -> Bool in
            return a.number - b.number < 0
        }
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension FavoritesVC: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
extension FavoritesVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "FavCell")
        // Showing pokemon data in cell if possible
        let pokemon: Pokemon
        pokemon = pokemonList[indexPath.row]

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

