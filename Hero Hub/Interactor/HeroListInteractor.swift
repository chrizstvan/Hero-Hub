//
//  HeroListInteractor.swift
//  Hero Hub
//
//  Created by Chris on 27/09/21.
//

import Foundation

protocol IHeroListInteractor {
    func fetchHeroList()
    func getHeroes() -> [Hero]
}

class HeroListInteractor: IHeroListInteractor {
    private let service: IHeroService
    private let presenter: IHeroListPresenter
    private var heroes: [Hero] = []
    
    init(presenter: IHeroListPresenter, service: IHeroService) {
        self.presenter = presenter
        self.service = service
    }
    
    func fetchHeroList() {
        service.requestHeroList { [weak self] result in
            switch result {
            case .success(let response):
                self?.heroes = response
                self?.presenter.presentSuccessGetHeroes()
            case .failure(let error):
                debugPrint("Failed fetch hero: \(error)")
                #warning("panggil presenter error view")
            }
        }
    }
    
    func getHeroes() -> [Hero] {
        self.heroes
    }
}

