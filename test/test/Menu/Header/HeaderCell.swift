//
//  HeaderCell.swift
//  test
//
//  Created by Егор Шкарин on 05.01.2022.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    static let reuseId = "HeaderCell"
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.textColor = UIColor(named: "buttonsColor")
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(named: "buttonsColor")?.cgColor
    }
    
    func configure(name: String) {
        label.text = name
    }

}
