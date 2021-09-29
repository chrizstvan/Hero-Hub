//
//  RolesCell.swift
//  Hero Hub
//
//  Created by Ronny on 27/09/21.
//

import UIKit

class RolesCell: UICollectionViewCell {
    static let identifier = "RolesCell"
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var topHighlightedView: UIView!
    @IBOutlet weak var highlightedView: UIView!
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.highlightedView.backgroundColor = self.isSelected ? .red : .lightGray
                self.topHighlightedView.backgroundColor = self.isSelected ? .red : .lightGray
                self.roleLabel.textColor = self.isSelected ? .red : .darkText
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.highlightedView.backgroundColor = .lightGray
        self.topHighlightedView.backgroundColor = .lightGray
        self.roleLabel.textColor = .darkText
        // Initialization code
    }

}
