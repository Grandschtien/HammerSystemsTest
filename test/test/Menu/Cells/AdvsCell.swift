//
//  AdvsCell.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//

import UIKit

class AdvsCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    static let reuseId = "AdvsCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        //image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        layer.cornerRadius = 20
    }
    
    func configure(nameOfPhoto: String) {
        image.image = UIImage(named: nameOfPhoto)
    }
}
