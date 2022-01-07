//
//  DishCell.swift
//  test
//
//  Created by Егор Шкарин on 06.01.2022.
//

import UIKit
import Kingfisher

class DishCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    static let reuseId = "DishCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
    }
    
    func configure(viewModel: DishesViewModel) {
        name.text = viewModel.title
        ingredients.text = viewModel.extendedIngredients
        image.kf.setImage(with: viewModel.resource, placeholder: UIImage(named: "menu"))
    }
}
