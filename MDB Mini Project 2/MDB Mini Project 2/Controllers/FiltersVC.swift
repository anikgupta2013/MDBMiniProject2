//
//  FiltersVC.swift
//  MDB Mini Project 2
//
//  Created by Anik Gupta on 9/19/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit

class FiltersVC: UIViewController {
    @IBOutlet weak var minAttackLabel: UILabel!
    @IBOutlet weak var minAttackSlider: UISlider!
    @IBOutlet weak var minDefenseLabel: UILabel!
    @IBOutlet weak var minDefenseSlider: UISlider!
    @IBOutlet weak var minHealthLabel: UILabel!
    @IBOutlet weak var minHealthSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pokemonList = PokemonGenerator.getPokemonArray()
        minAttackSlider.minimumValue = 0
        minDefenseSlider.minimumValue = 0
        minHealthSlider.minimumValue = 0
        
        minAttackSlider.maximumValue = Float(pokemonList.sorted(by: { (a, b) -> Bool in
            return a.attack - b.attack > 0
        })[0].attack!)
        minDefenseSlider.maximumValue = Float(pokemonList.sorted(by: { (a, b) -> Bool in
            return a.defense - b.defense > 0
        })[0].defense!)
        minHealthSlider.maximumValue = Float(pokemonList.sorted(by: { (a, b) -> Bool in
            return a.health - b.health > 0
        })[0].health!)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func minAttackChanged(_ sender: Any) {
        minAttackLabel.text = "Minimum Attack: \(Int(minAttackSlider.value))"
    }
    
    @IBAction func minDefenseChanged(_ sender: Any) {
        minDefenseLabel.text = "Minimum Defense: \(Int(minDefenseSlider.value))"
    }
    
    @IBAction func minHealthChanged(_ sender: Any) {
        minHealthLabel.text = "Minimum Health: \(Int(minHealthSlider.value))"
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
