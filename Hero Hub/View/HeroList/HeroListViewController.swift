//
//  HeroListViewController.swift
//  Hero Hub
//
//  Created by Chris on 27/09/21.
//

import UIKit

protocol IHeroViewController: AnyObject {
    func displaySuccessGetHeroes()
    func displayErrorGetHeroes(errorStr: String)
    func navigateToDetail(hero: Hero, similarHeroes: [Hero])
}

class HeroListViewController: UIViewController {
    
    private var interactor: IHeroListInteractor?
    private let screenSize = UIScreen.main.bounds
    private var selectedRole = "All"
    
    @IBOutlet weak var categoryTabs: UICollectionView!
    @IBOutlet weak var heroesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }


    private func setup() {
        let presenter = HeroListPresenter(view: self)
        interactor = HeroListInteractor(presenter: presenter, service: HeroListService(), localDB: LocalDBWorker())
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Heroes"
        
        registerCell()
    }
    
    private func registerCell() {
        categoryTabs.register(UINib(nibName: RolesCell.identifier, bundle: .main), forCellWithReuseIdentifier: RolesCell.identifier)
        categoryTabs.dataSource = self
        categoryTabs.delegate = self
        
        heroesCollection.register(UINib(nibName: HeroCell.identifier, bundle: .main), forCellWithReuseIdentifier: HeroCell.identifier)
        heroesCollection.dataSource = self
        heroesCollection.delegate = self
    }
    
    private func fetchData() {
        interactor?.fetchHeroList()
    }

}

extension HeroListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryTabs:
            return interactor?.getHeroesRole().count ?? .zero
        case heroesCollection:
            return interactor?.getHeroes().count ?? .zero
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryTabs:
            guard let cell = categoryTabs.dequeueReusableCell(withReuseIdentifier: RolesCell.identifier, for: indexPath) as? RolesCell,
                  let roles = interactor?.getHeroesRole() else {
                return UICollectionViewCell()
            }
            let role = roles[indexPath.item]
            cell.roleLabel.text = role
            cell.isSelected = selectedRole.contains(role) ? true : false
            return cell
        case heroesCollection:
            guard let cell = heroesCollection.dequeueReusableCell(withReuseIdentifier: HeroCell.identifier, for: indexPath) as? HeroCell else {
                return UICollectionViewCell()
            }
            let viewModel = interactor?.getHeroesViewModel()[indexPath.item]
            cell.configure(viewModel: viewModel)
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case categoryTabs:
            return CGSize(width: 150, height: 56)
        case heroesCollection:
            let cardW = CGFloat((screenSize.width / 2) - 16)
            let cardH = CGFloat(cardW * 0.8)
            return CGSize(width: cardW, height: cardH)
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == heroesCollection {
            return UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
        }
        return UIEdgeInsets()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoryTabs:
            guard let role = interactor?.getHeroesRole()[indexPath.item] else { return }
            selectedRole = role
            interactor?.getHeroesByRole(role: role)
        case heroesCollection:
            guard let hero = interactor?.getHeroes()[indexPath.item] else { return }
            interactor?.prepareToNavigate(hero: hero)
        default:
            break
        }
    }
}

extension HeroListViewController: IHeroViewController {
    func displaySuccessGetHeroes() {
        DispatchQueue.main.async { [weak self] in
            self?.categoryTabs.reloadData()
            self?.heroesCollection.reloadData()
        }
    }
    
    func displayErrorGetHeroes(errorStr: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Error", message: errorStr, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self?.present(alert, animated: true)
        }
    }
    
    func navigateToDetail(hero: Hero, similarHeroes: [Hero]) {
        let destination = HeroDetailViewController(hero: hero, similarHeroes: similarHeroes)
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
}
