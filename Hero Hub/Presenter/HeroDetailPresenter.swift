//
//  HeroDetailPresenter.swift
//  Hero Hub
//
//  Created by Chris on 28/09/21.
//

import Foundation

protocol IHeroDetailPresenter {
    func presentHeroDetail(response: HeroDetail.Response)
}

class HeroDetailPresenter: IHeroDetailPresenter {
    private weak var view: IHeroDetailViewController?
    
    init(view: IHeroDetailViewController) {
        self.view = view
    }
    
    func presentHeroDetail(response: HeroDetail.Response) {
        let viewModel = HeroDetail.ViewModel.init(hero: response.hero)
        view?.displayHeroDetail(viewModel: viewModel)
    }
}
