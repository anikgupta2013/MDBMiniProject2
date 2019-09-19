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
        /*guard let poke = detailPokemon else{
            print("bye")
            return
        }*/
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
    
    @IBAction func addFavoritesPressed(_ sender: Any) {
        
    }
    
    @IBAction func searchWebPressed(_ sender: Any) {
        if canOpenWeb {
            UIApplication.shared.open(URL(string: "https://google.com/search?q=\(detailPokemon!.name!)")!)
        }
        
        //self.performSegue(withIdentifier: "toWebView", sender: self)
    }
}
