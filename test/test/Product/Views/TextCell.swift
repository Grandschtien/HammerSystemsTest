//
//  TextCell.swift
//  test
//
//  Created by Егор Шкарин on 12.01.2022.
//

import UIKit

class TextCell: UITableViewCell {
    
    private let label = UILabel()
    
    func configure(viewModel: DishesViewModel, section: Int) {
        setupLabel()
        switch section {
        case 0:
            label.text = viewModel.title
            label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
            label.numberOfLines = 0
        case 1:
            label.text = viewModel.extendedIngredients
            label.numberOfLines = 0
            label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            label.textColor = #colorLiteral(red: 0.7233768702, green: 0.7237185836, blue: 0.7336833477, alpha: 0.8470588235)
        case 2:
            label.text = viewModel.instructions
            label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            label.numberOfLines = 0
        default:
            fatalError("Invalid number of section")
        }
    }
    
}

extension TextCell {
    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
    }
}
