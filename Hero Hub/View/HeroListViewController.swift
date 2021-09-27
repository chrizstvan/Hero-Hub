//
//  HeroListViewController.swift
//  Hero Hub
//
//  Created by Chris on 27/09/21.
//

import UIKit

protocol IHeroViewController: AnyObject {
    func displaySuccessGetHeroes()
    func displayErrorGetHeroes()
}

class HeroListViewController: UIViewController {
    private var interactor: IHeroListInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }


    private func setup() {
        let presenter = HeroListPresenter(view: self)
        interactor = HeroListInteractor(presenter: presenter, service: HeroListService())
    }
    
    private func fetchData() {
        interactor?.fetchHeroList()
    }

}

extension HeroListViewController: IHeroViewController {
    func displaySuccessGetHeroes() {
        let heroes = interactor?.getHeroes()
        print("HERO LIST: \(heroes)")
    }
    
    func displayErrorGetHeroes() {
        #warning("Display loading")
    }
    
    
}
