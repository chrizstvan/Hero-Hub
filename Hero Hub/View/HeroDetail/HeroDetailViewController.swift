//
//  HeroDetailViewController.swift
//  Hero Hub
//
//  Created by Chris on 28/09/21.
//

import UIKit

protocol IHeroDetailViewController: AnyObject {
    func displayHeroDetail(viewModel: HeroDetail.ViewModel)
}

class HeroDetailViewController: UIViewController {
    private var interactor: IHeroDetailInteractor?
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroName: UILabel!
    @IBOutlet weak var similarHeroesTableVIew: UITableView!
    
    
    convenience init(hero: Hero, similarHeroes: [Hero]) {
        let bundle = Bundle(for: type(of: self))
        self.init(nibName: "HeroDetailViewController", bundle: bundle)
        setup(hero: hero, similarHeroes: similarHeroes)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.handleHeroDetail()
        similarHeroesTableVIew.register(UINib(nibName: SimilarHeroCell.identifier, bundle: .main), forCellReuseIdentifier: SimilarHeroCell.identifier)
        similarHeroesTableVIew.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setup(hero: Hero, similarHeroes: [Hero]) {
        let presenter = HeroDetailPresenter(view: self)
        interactor = HeroDetailInteractor(presenter: presenter, hero: hero, similarHeroes: similarHeroes)
    }
}

extension HeroDetailViewController: IHeroDetailViewController {
    func displayHeroDetail(viewModel: HeroDetail.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            let url = URL(string: viewModel.image!)
            self?.heroImage.kf.setImage(with: url)
            self?.heroName.text = viewModel.primaryAttr
            self?.navigationItem.title = viewModel.name
            self?.similarHeroesTableVIew.reloadData()
        }
    }
}

extension HeroDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.getSimilarHeroes().count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = similarHeroesTableVIew.dequeueReusableCell(withIdentifier: SimilarHeroCell.identifier, for: indexPath) as? SimilarHeroCell else {
            return UITableViewCell()
        }
        let similarHeroes = interactor?.getSimilarHeroes()[indexPath.row]
        cell.nameLabel.text = "\(similarHeroes?.localizedName) agi: \(similarHeroes?.moveSpeed)"
        return cell
    }
}
