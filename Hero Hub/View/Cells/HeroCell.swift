//
//  HeroCell.swift
//  Hero Hub
//
//  Created by Ronny on 28/09/21.
//

import UIKit
import Kingfisher

class HeroCell: UICollectionViewCell {
    static let identifier = "HeroCell"
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(viewModel: HeroList.ViewModel?) {
        nameLabel.text = viewModel?.name
        
        guard let urlImage = viewModel?.image else { return }
        heroImageView.kf.setImage(with: URL(string: urlImage))
    }
}
