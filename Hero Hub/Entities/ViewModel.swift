//
//  ViewModel.swift
//  Hero Hub
//
//  Created by Ronny on 28/09/21.
//

import Foundation

enum HeroList {
    struct Response {
        let heroes: [Hero]
    }
    struct ViewModel {
        let name: String?
        var image: String?
        
        init(hero: Hero) {
            self.name = hero.localizedName
            self.image = hero.img.imageURLFormat
        }
    }
}

enum HeroDetail {
    struct Response {
        let hero: Hero
        let similarHero: [Hero]?
    }
    struct ViewModel {
        let name: String?
        let primaryAttr: String?
        var image: String?
        var icon: String?
        let roles: String?
        let baseAttack: String?
        let baseArmor: String?
        let moveSpeed: String?
        let baseHealth: String?
        let baseMana: String?
    
        init(hero: Hero) {
            self.name = hero.localizedName
            self.primaryAttr = hero.primaryAttr
            self.image = hero.img.imageURLFormat
            self.icon = hero.icon.imageURLFormat
            self.roles = hero.roles.joined(separator: " • ")
            self.baseAttack = "\(hero.baseAttackMin) - \(hero.baseAttackMax)"
            self.baseArmor = "\(hero.baseArmor)"
            self.moveSpeed = "\(hero.moveSpeed)"
            self.baseHealth = "\(hero.baseHealth)"
            self.baseMana = "\(hero.baseMana)"
        }
    }
}
