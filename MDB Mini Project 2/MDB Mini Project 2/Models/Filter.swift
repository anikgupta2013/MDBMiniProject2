//
//  Filter.swift
//  MDB Mini Project 2
//
//  Created by Anik Gupta on 9/19/19.
//  Copyright © 2019 Anik Gupta. All rights reserved.
//

import Foundation
class Filter {
    let minAttack: Int
    let minDefense: Int
    let minHealth: Int
    let type: [String]
    
    
    // Takes filtering data
    init(){
        self.minAttack = 0
        self.minDefense = 0
        self.minHealth = 0
        self.type = []
    }
    
    init(_ mAttack: Int, _ mDefense: Int, _ mHealth: Int, _ types: [String]){
        self.minAttack = mAttack
        self.minDefense = mDefense
        self.minHealth = mHealth
        self.type = types
    }
    
    
    // Checks if a pokemon meets the filtering data
    func isValid(pokemon: Pokemon) -> Bool {
        var valid = true

        for s in type {
            valid = valid && !pokemon.types.contains(s)
        }
        
        if type.count == 0 {
            valid = true
        }
        
        valid = valid && minAttack <= pokemon.attack
        valid = valid && minDefense <= pokemon.defense
        valid = valid && minHealth <= pokemon.health
        
        return valid
    }
}
