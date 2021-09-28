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
    @IBOutlet weak var highlightedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
