//
//  HeroListInteractor.swift
//  Hero Hub
//
//  Created by Chris on 27/09/21.
//

import Foundation
import RealmSwift

protocol IHeroListInteractor {
    func fetchHeroList()
    func getHeroes() -> [Hero]
    func getHeroesViewModel() -> [HeroList.ViewModel]
    func getHeroesRole() -> [String]
    func getHeroesByRole(role: String)
    func prepareToNavigate(hero: Hero)
}

class HeroListInteractor: IHeroListInteractor {
    private let service: IHeroService
    private let presenter: IHeroListPresenter
    private let localDB: LocalDBWorker
    private var heroes: [Hero] = []
    private var heroByRoles: [String: [Hero]] = [:]
    private var filtredHeroes: [Hero] = []
    
    init(presenter: IHeroListPresenter, service: IHeroService, localDB: LocalDBWorker) {
        self.presenter = presenter
        self.service = service
        self.localDB = localDB
    }
    
    func fetchHeroList() {
        guard let realm = localDB.realm else { return }
        if realm.isEmpty {
            fetchFromRemote()
        } else {
            loadFromLocal()
        }
    }
    
    private func fetchFromRemote() {
        service.requestHeroList { [weak self] result in
            switch result {
            case .success(let response):
                self?.heroes = response
                self?.setHeroByRolesDictionary()
                self?.presenter.presentSuccessGetHeroes()
            case .failure(let error):
                self?.presenter.presentFailedGetHeros(strError: error.localizedDescription)
            }
        }
        saveToLocal(self.heroes)
    }
    
    func getHeroes() -> [Hero] {
        filtredHeroes.isEmpty ? self.heroes : filtredHeroes
    }
    
    func getHeroesViewModel() -> [HeroList.ViewModel] {
        let currentHeroes = filtredHeroes.isEmpty ? self.heroes : filtredHeroes
        let viewModels = currentHeroes.map { HeroList.ViewModel.init(hero: $0) }
        return viewModels
    }
    
    func getHeroesRole() -> [String] {
        var allRoles = [String]()
        self.heroes.forEach { allRoles.append(contentsOf: $0.roles) }
        allRoles = allRoles.uniqued()
        if !heroes.isEmpty { allRoles.insert("All", at: 0) }
        return allRoles
    }
    
    func getHeroesByRole(role: String) {
        self.filtredHeroes = heroByRoles[role] ?? self.heroes
        presenter.presentSuccessGetHeroes()
    }
    
    func prepareToNavigate(hero: Hero) {
        let primaryAtt = hero.primaryAttr
        var heroes = self.heroes.filter {$0.id != hero.id }
        switch primaryAtt {
        case "agi":
            heroes = heroes.sorted { $0.moveSpeed > $1.moveSpeed }
        case "str":
            heroes = heroes.sorted { $0.baseAttackMax > $1.baseAttackMax }
        case "int":
            heroes = heroes.sorted { $0.baseMana > $1.baseMana }
        default:
            break
        }
        
        let similarHeroes = Array(heroes.prefix(3))
        presenter.prepareToNavigateFinished(hero: hero, similarHeroes: similarHeroes)
    }

    // MARK: Helper Function
    
    private func setHeroByRolesDictionary() {
        let roles = getHeroesRole()
        for role in roles {
            self.heroByRoles[role] = filterHeroesByRoles(role)
        }
    }
    
    private func filterHeroesByRoles(_ role: String) -> [Hero] {
        guard role != "All" else { return self.heroes }
        let filteredHeroes = self.heroes.filter { $0.roles.contains(role) }
        return filteredHeroes
    }
}

// MARK: Realm
extension HeroListInteractor {
    private func saveToLocal(_ data: [Hero]) {
        //print("REALM PATH: \(Realm.Configuration.defaultConfiguration.fileURL)")
        guard let realm = localDB.realm else { return }
        DispatchQueue.main.async {
            for hero in data {
                do {
                    try realm.write {
                        realm.add(hero, update: .modified)
                    }
                } catch(let error) {
                    debugPrint("Error saving to local: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func loadFromLocal() {
        guard let realm = localDB.realm else { return }
        DispatchQueue.main.async { [weak self] in
            self?.heroes = realm.objects(Hero.self).toArray(ofType: Hero.self) as [Hero]
            self?.setHeroByRolesDictionary()
            self?.presenter.presentSuccessGetHeroes()
        }
        
        fetchFromRemote()
    }
}
