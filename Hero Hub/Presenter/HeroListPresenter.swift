//
//  HeroListPresenter.swift
//  Hero Hub
//
//  Created by Chris on 27/09/21.
//

import Foundation

protocol IHeroListPresenter {
    func presentSuccessGetHeroes()
    func prepareToNavigateFinished(hero: Hero, similarHeroes: [Hero])
}

class HeroListPresenter: IHeroListPresenter {
    private weak var view: IHeroViewController?
    
    init(view: IHeroViewController) {
        self.view = view
    }
    
    func presentSuccessGetHeroes() {
        view?.displaySuccessGetHeroes()
    }
    
    func prepareToNavigateFinished(hero: Hero, similarHeroes: [Hero]) {
        view?.navigateToDetail(hero: hero, similarHeroes: similarHeroes)
    }
}
