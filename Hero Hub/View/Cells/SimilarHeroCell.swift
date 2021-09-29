//
//  SimilarHeroCell.swift
//  Hero Hub
//
//  Created by Ronny on 28/09/21.
//

import UIKit

class SimilarHeroCell: UITableViewCell {
    static let identifier = "SimilarHeroCell"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heroeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        heroeImageView.layer.cornerRadius = heroeImageView.frame.width / 2
        heroeImageView.clipsToBounds = true
    }
    
    func configureCell(viewModel: HeroDetail.ViewModel) {
        nameLabel.text = viewModel.name
        guard let imageUrl = viewModel.icon, let url = URL(string: imageUrl) else { return }
        heroeImageView.kf.setImage(with: url)
    }
}
