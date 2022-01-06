//
//  DishCell.swift
//  test
//
//  Created by Егор Шкарин on 06.01.2022.
//

import UIKit

class DishCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    static let reuseId = "DishCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        image.layer.masksToBounds = true
        image.layer.borderWidth = 1.0
        image.layer.borderColor = UIColor.red.cgColor
        image.layer.cornerRadius = 20
    }
    
    func configure() {
        name.text = "agafgagadaaf"
        ingredients.text = "xcvfgh fghjk cfghj ghjk vbghjk vbnhjm vbnhjm vbnmj vbhnj vbnm"
        image.image = UIImage(named: "contacts")
    }
}
