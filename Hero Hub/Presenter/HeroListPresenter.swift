//
//  HeroListPresenter.swift
//  Hero Hub
//
//  Created by Chris on 27/09/21.
//

import Foundation

protocol IHeroListPresenter {
    func presentSuccessGetHeroes()
}

class HeroListPresenter: IHeroListPresenter {
    private weak var view: IHeroViewController?
    
    init(view: IHeroViewController) {
        self.view = view
    }
    
    func presentSuccessGetHeroes() {
        view?.displaySuccessGetHeroes()
    }
}
