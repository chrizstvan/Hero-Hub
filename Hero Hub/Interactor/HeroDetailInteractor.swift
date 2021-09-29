//
//  HeroDetailInteractor.swift
//  Hero Hub
//
//  Created by Chris on 28/09/21.
//

import Foundation

protocol IHeroDetailInteractor: AnyObject {
    func handleHeroDetail()
    func getSimilarHeroes() -> [HeroDetail.ViewModel]
}

class HeroDetailInteractor: IHeroDetailInteractor {
    private var presenter: IHeroDetailPresenter?
    private var hero: Hero
    private var similarHeroes: [Hero]
    
    init(presenter: IHeroDetailPresenter, hero: Hero, similarHeroes: [Hero]) {
        self.presenter = presenter
        self.hero = hero
        self.similarHeroes = similarHeroes
    }
    
    func handleHeroDetail() {
        let response = HeroDetail.Response.init(hero: self.hero, similarHero: similarHeroes)
        presenter?.presentHeroDetail(response: response)
    }
    
    func getSimilarHeroes() -> [HeroDetail.ViewModel] {
        let viewModels = similarHeroes.map { HeroDetail.ViewModel.init(hero: $0) }
        return viewModels
    }
}
