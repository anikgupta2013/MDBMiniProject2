//
//  FiltersVC.swift
//  MDB Mini Project 2
//
//  Created by Anik Gupta on 9/19/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import UIKit

class FiltersVC: UIViewController {
    
    // Min value sliders and labels
    @IBOutlet weak var minAttackLabel: UILabel!
    @IBOutlet weak var minAttackSlider: UISlider!
    @IBOutlet weak var minDefenseLabel: UILabel!
    @IBOutlet weak var minDefenseSlider: UISlider!
    @IBOutlet weak var minHealthLabel: UILabel!
    @IBOutlet weak var minHealthSlider: UISlider!
    
    // Action buttons
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var randomButton: TypeButton!
    
    // Type buttons
    @IBOutlet weak var poison: TypeButton!
    @IBOutlet weak var grass: TypeButton!
    @IBOutlet weak var dark: TypeButton!
    @IBOutlet weak var ground: TypeButton!
    @IBOutlet weak var dragon: TypeButton!
    @IBOutlet weak var ice: TypeButton!
    @IBOutlet weak var fire: TypeButton!
    @IBOutlet weak var normal: TypeButton!
    @IBOutlet weak var fairy: TypeButton!
    @IBOutlet weak var bug: TypeButton!
    @IBOutlet weak var fighting: TypeButton!
    @IBOutlet weak var psychic: TypeButton!
    @IBOutlet weak var electric: TypeButton!
    @IBOutlet weak var rock: TypeButton!
    @IBOutlet weak var flying: TypeButton!
    @IBOutlet weak var steel: TypeButton!
    @IBOutlet weak var ghost: TypeButton!
    @IBOutlet weak var water: TypeButton!
    
    var types : [TypeButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initializing min values for sliders
        let pokemonList = PokemonGenerator.getPokemonArray()
        minAttackSlider.minimumValue = 0
        minDefenseSlider.minimumValue = 0
        minHealthSlider.minimumValue = 0
        
        // Initializing max values for sliders based on pokemon data
        minAttackSlider.maximumValue = Float(pokemonList.sorted(by: { (a, b) -> Bool in
            return a.attack - b.attack > 0
        })[0].attack!)
        minDefenseSlider.maximumValue = Float(pokemonList.sorted(by: { (a, b) -> Bool in
            return a.defense - b.defense > 0
        })[0].defense!)
        minHealthSlider.maximumValue = Float(pokemonList.sorted(by: { (a, b) -> Bool in
            return a.health - b.health > 0
        })[0].health!)
        
        // Create array of type buttons
        types = [poison, grass, dark, ground, dragon, ice, fire, normal, fairy, bug, fighting, psychic, electric, rock, flying, steel, ghost, water]
        
        
        // In case a filter is already applied
        minAttackSlider.value = Float(SearchVC.filter.minAttack)
        minDefenseSlider.value = Float(SearchVC.filter.minDefense)
        minHealthSlider.value = Float(SearchVC.filter.minHealth)
        minAttackLabel.text = "Minimum Attack: \(Int(minAttackSlider.value))"
        minDefenseLabel.text = "Minimum Defense: \(Int(minDefenseSlider.value))"
        minHealthLabel.text = "Minimum Health: \(Int(minHealthSlider.value))"
        
        // Only buttons that have been selected will be in filter.type
        for type in types {
            type.isSelected = !SearchVC.filter.type.contains(type.currentTitle!)
        }
        
        randomButton.isSelected = SearchVC.randomTwenty
    }
    
    // Changing values of sliders
    @IBAction func minAttackChanged(_ sender: Any) {
        minAttackLabel.text = "Minimum Attack: \(Int(minAttackSlider.value))"
    }
    
    @IBAction func minDefenseChanged(_ sender: Any) {
        minDefenseLabel.text = "Minimum Defense: \(Int(minDefenseSlider.value))"
    }
    
    @IBAction func minHealthChanged(_ sender: Any) {
        minHealthLabel.text = "Minimum Health: \(Int(minHealthSlider.value))"
    }
    
    
    // Filter is to be applied
    @IBAction func applyPressed(_ sender: Any) {
        
        var stringTypesSelected : [String] = []
        // If a type button is pressed, add the name of type to array
        for button in types {
            if !button.isSelected {
                stringTypesSelected.append(button.currentTitle!)
            }
        }
        // create a new filter
        let fil = Filter(Int(minAttackSlider.value), Int(minDefenseSlider.value), Int(minHealthSlider.value), stringTypesSelected)
        SearchVC.setFilter(f: fil)
        SearchVC.randomTwenty = randomButton.isSelected
        
        
        
    }
    @IBAction func resetPressed(_ sender: Any) {
        reset()
    }
    func reset(){
        minAttackSlider.value = 0
        minDefenseSlider.value = 0
        minHealthSlider.value = 0
        for button in types {
            button.isSelected = true
        }
        let fil = Filter(Int(minAttackSlider.value), Int(minDefenseSlider.value), Int(minHealthSlider.value), [])
        SearchVC.setFilter(f: fil)
        SearchVC.randomTwenty = false
        randomButton.isSelected = false
    }
}
