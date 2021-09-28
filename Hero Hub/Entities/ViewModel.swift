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
    
        init(hero: Hero) {
            self.name = hero.localizedName
            self.primaryAttr = hero.primaryAttr
            self.image = hero.img.imageURLFormat
        }
    }
}
