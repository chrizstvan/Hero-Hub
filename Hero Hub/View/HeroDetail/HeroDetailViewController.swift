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
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var similarHeroesTableVIew: UITableView!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var armorLabel: UILabel!
    @IBOutlet weak var movementLabel: UILabel!
    @IBOutlet weak var primaryAttribute: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var manaLabel: UILabel!
    
    
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
    
    private func configureUI(viewModel: HeroDetail.ViewModel) {
        let url = URL(string: viewModel.image!)
        self.heroImage.kf.setImage(with: url)
        self.roleLabel.text = viewModel.roles
        self.attackLabel.text = viewModel.baseAttack
        self.armorLabel.text = viewModel.baseArmor
        self.healthLabel.text = viewModel.baseHealth
        self.manaLabel.text = viewModel.baseMana
        self.movementLabel.text = viewModel.moveSpeed
        self.primaryAttribute.text = viewModel.primaryAttr
        self.navigationItem.title = viewModel.name
    }
}

extension HeroDetailViewController: IHeroDetailViewController {
    func displayHeroDetail(viewModel: HeroDetail.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.configureUI(viewModel: viewModel)
            self?.similarHeroesTableVIew.reloadData()
        }
    }
}

extension HeroDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.getSimilarHeroes().count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = similarHeroesTableVIew.dequeueReusableCell(withIdentifier: SimilarHeroCell.identifier, for: indexPath) as? SimilarHeroCell,
              let similarHeroes = interactor?.getSimilarHeroes()[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configureCell(viewModel: similarHeroes)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Similar Heroes"
    }
    
}
