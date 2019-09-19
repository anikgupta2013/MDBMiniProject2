//
//  DetailVC.swift
//  MDB Mini Project 2
//
//  Created by Anik Gupta on 9/18/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var detailPokemon: Pokemon?
    var urlWeb: URL?
    var canOpenWeb = false
    
    
    //All attributes
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var specialAttackLabel: UILabel!
    @IBOutlet weak var specialDefenseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var webButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = detailPokemon?.name
        typeLabel.text = detailPokemon?.types.joined(separator: " | ")
        speciesLabel.text = detailPokemon?.species
        attackLabel.text = "Attack: \(detailPokemon!.attack!)"
        defenseLabel.text = "Defense: \(detailPokemon!.defense!)"
        healthLabel.text = "Health: \(detailPokemon!.health!)"
        specialAttackLabel.text = "Special Attack: \(detailPokemon!.specialAttack!)"
        specialDefenseLabel.text = "Special Defense: \(detailPokemon!.specialDefense!)"
        speedLabel.text = "Speed: \(detailPokemon!.speed!)"
        totalLabel.text = "Total: \(detailPokemon!.total!)"
    
        let defaults = UserDefaults.standard
        var arr = defaults.array(forKey: "savedPokemon") as? [String] ?? [String]()
        if arr.contains(detailPokemon!.name) {
            favoriteButton.isEnabled = false
        }
        
        if let url = URL(string: "https://google.com/search?q=\(detailPokemon!.name!)") {
            canOpenWeb = true
        }
        else {
            webButton.isEnabled = false
        }
        
        guard let url = URL(string: detailPokemon!.imageUrl)?.absoluteString else {
            return
        }
        do {
            let data = try Data(contentsOf: URL(string: detailPokemon!.imageUrl)!)
        } catch {
            return
        }
        profileImage.image = UIImage(data: try! Data(contentsOf: URL(string: detailPokemon!.imageUrl)!))
        
    }
    // If favorite button is pressed, add to UserDefaults
    @IBAction func addFavoritesPressed(_ sender: Any) {
        let defaults = UserDefaults.standard
        var arr = defaults.array(forKey: "savedPokemon") as? [String] ?? [String]()
        arr.append(detailPokemon!.name)
        defaults.set(arr, forKey: "savedPokemon")
        favoriteButton.isEnabled = false
    }
    // If it is possible to open website, open
    @IBAction func searchWebPressed(_ sender: Any) {
        if canOpenWeb {
            UIApplication.shared.open(URL(string: "https://google.com/search?q=\(detailPokemon!.name!)")!)
        }
    }
}
